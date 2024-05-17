# .gitignore

```
xcuserdata/
Package.resolved
*.xcconfig
*.xcprivacy
.DS_Store
```

# Commit Convention

```
Feat: 새로운 기능
Fix: 버그 수정 (내가 의도하지 않은 동작은 모두 버그이다)
Style: 코드 포맷팅, 세미콜론 누락
Refactor: 코드 리팩토링 -> 기능이 바뀌지 않음
Chore: 패키지 매니저 추가, 뭔가 뭔가인 일 (파일 단순 추가, 단순 삭제)

--- 커밋 메시지 예시 ---
Feat: 새로운 기능 추가

새로운 기능 추가
 - 새로운 기능 1 추가 (optional)
 - 새로운 기능 2 추가 (optional)
--------------------
```

# 브랜치 규칙

```
- main : 완성되어 배포가 가능한 브랜치
- develop : 배포전의 개발 브랜치
- feature : 특정 기능 구현을 위한 브랜치 & 구현이 끝난 후에는 PR 을 통해 삭제
```

# 브랜치 이름 작성 규칙

```html
<이슈 번호>-소문자-소문자-소문자…
```