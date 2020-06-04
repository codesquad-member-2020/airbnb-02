# airbnb-02
-------------------------

# 숙소예약 서비스 2팀 그라운드 룰

## 공통 작업시간
* 오후 1시 30분 스크럼
* 오후 2시 - 6시 일반적으로 공통 작업시간
* 회고는 매주 금요일 데모 이후
* 스크럼은 위키에 쓰고, 팀장제로 하는데, 팀장 1주, 매주 가위바위보

## 브랜치 규칙
* `master`: 최종 브랜치 - 프로젝트 3주차 금요일 마지막 머지
* `dev`: 디폴트 브랜치
    * `iOS/dev`: iOS 개발 브랜치
        * `iOS/feature/issue-xxx`: iOS 기능 추가 브랜치
    * `BE/dev`: 백엔드 개발 브랜치
        * `BE/fix/issue-xxx`: BE 기능 추가 브랜치
        * `BE/fix/issue-xxx`
* `deploy`: 배포 브랜치
* 모든 머지는 PR을 기반으로 한다.

## 커밋 메시지 규칙
```
[#36] feat: something something...

- description....
```

```
feat: (new feature for the user, not a new feature for build script)
fix: (bug fix for the user, not a fix to a build script)
docs: (changes to the documentation)
style: (formatting, missing semi colons, etc; no production code change)
refactor: (refactoring production code, eg. renaming a variable)
test: (adding missing tests, refactoring tests; no production code change)
chore: (updating grunt tasks etc; no production code change)
```

## PR, Issue, 문서관리 규칙
* PR, Issue
    * PR와 이슈에 어느 클래스인지 라벨을 꼭 붙이자.
    * PR에 linked issue를 꼭 붙이자.
    * PR 제목에 [클래스]를 붙인다.
* 문서관리
    * API: postman + iOS를 위해 nullable 여부 문서에 명시

## Project References

- [배포 업데이트 로그]
- [API document](https://documenter.getpostman.com/view/10828534/Szt5equ5?version=latest)