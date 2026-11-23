#!/usr/bin/env bash
# 새 worktree에 메인 worktree의 로컬 env 파일을 그대로 복사한다.
# - 내용은 열거나 출력하지 않는다. 경로와 결과만 출력한다.
# - Git이 무시하고 추적하지 않는 .env* 파일만 대상이다(.env.example·.env.sample,
#   node_modules·.next·dist·build 같은 산출물 폴더 안의 파일 제외).
# - 대상에 이미 있는 파일은 덮어쓰지 않는다.
# 사용: copy-worktree-env.sh <메인 worktree 경로> <대상 worktree 경로>
set -euo pipefail

main="${1:?메인 worktree 경로가 필요합니다}"
target="${2:?대상 worktree 경로가 필요합니다}"
main="$(cd "$main" && pwd)"
target="$(cd "$target" && pwd)"

main_top="$(git -C "$main" rev-parse --show-toplevel)"
target_common="$(cd "$target" && cd "$(git rev-parse --git-common-dir)" && pwd)"
main_common="$(cd "$main" && cd "$(git rev-parse --git-common-dir)" && pwd)"
if [ "$target_common" != "$main_common" ]; then
  echo "중단: 두 경로가 같은 저장소의 worktree가 아닙니다." >&2
  exit 1
fi
if [ "$main_top" = "$target" ]; then
  echo "중단: 메인과 대상이 같습니다." >&2
  exit 1
fi

copied=0
skipped=0
cd "$main_top"
# 무시된(추적되지 않는) 파일 중 .env* 만 고른다
while IFS= read -r rel; do
  base="$(basename "$rel")"
  case "$base" in
    .env.example | .env.sample) continue ;;
  esac
  # 의존성·빌드 산출물 안의 env(예: .next/standalone/*/.env.production)는 제외한다
  case "/$rel" in
    */node_modules/* | */.next/* | */dist/* | */build/* | */out/* | */.turbo/*) continue ;;
  esac
  dest="$target/$rel"
  if [ -e "$dest" ]; then
    if cmp -s "$rel" "$dest"; then
      echo "같음(건너뜀): $rel"
    else
      echo "다름(덮어쓰지 않음): $rel"
    fi
    skipped=$((skipped + 1))
    continue
  fi
  if ! git -C "$target" check-ignore -q "$rel"; then
    echo "대상에서 무시되지 않아 건너뜀: $rel"
    skipped=$((skipped + 1))
    continue
  fi
  mkdir -p "$(dirname "$dest")"
  cp -p "$rel" "$dest"
  if cmp -s "$rel" "$dest"; then
    echo "복사: $rel"
    copied=$((copied + 1))
  else
    echo "복사 확인 실패: $rel" >&2
    exit 1
  fi
done < <(git ls-files --others --ignored --exclude-standard -- ':(glob)**/.env*' ':(glob).env*')

echo "완료: 복사 ${copied}개, 건너뜀 ${skipped}개"
