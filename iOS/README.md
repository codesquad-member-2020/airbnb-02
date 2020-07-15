# Airbnb iOS

숙소예약 서비스 iOS 앱

> 팀원: Jason, Heidi

## Task 목록

[스프레드시트 링크][spreadsheet]

## 단계별 구현 내용

### 메인 검색 화면, 필터 화면 구현

> [PR #57 [iOS] 메인화면, 필터화면 뷰 구현][pr57]

* [Pair] 기본 탭바 컨트롤러와 뷰 컨트롤러 구현 [Issue][issue3] [PR][pr4]
* [Jason] Tab Bar에 연결된 뷰 컨트롤러 생성 부분 리팩토링 [Issue][issue11] [PR][pr12]
* [Heidi] 코드로 구현한 탭바 컨트롤러를 스토리보드로 변경 [Issue][issue15] [PR][pr16]
* [Jason] 커스텀 뱃지 레이블 구현 [Issue][issue6] [PR][pr20]
* [Jason] 커스텀 서치 텍스트필드 구현 [Issue][issue7] [PR][pr22]
* [Jason] 커스텀 Guide 레이블 구현 [Issue][issue8] [PR][pr23]
* [Heidi] 상단 커스텀 버튼 클래스 구현 및 버튼 상속 관계 설계 [Issue][issue14] [PR][pr25]
* [Jason] 불필요한 뷰모델 제거 [Issue][issue27] [PR][pr28]
* [Heidi] 현재까지 구현된 커스텀 뷰들을 스토리보드에 올리고 레이아웃 지정 [Issue][issue30] [PR][pr35]
* [Jason] 이미지 페이징 뷰 구현 [Issue][issue5] [PR][pr37]
* [Jason] 뷰 그림자 설정 메서드 프로토콜화 [Issue][issue34] [PR][pr38]
* [Jason] 맵 버튼 구현 [Issue][issue40] [PR][pr46]
* [Heidi] Filter VC 및 화면 전환 구현 [Issue][issue49] [PR][pr56]

**실행 결과**

![result1](result1.png)

### 메인 검색 화면 완성 및 테스트

> [PR #119 [iOS] 메인 검색 화면 완성 및 테스트][pr119]

* [Jason] 메인 화면 네트워크 응답 모델 객체 구현 [Issue][issue43] [PR][pr53]
* [Heidi] 하트 커스텀 버튼 구현 [Issue][issue61] [PR][pr62]
* [Jason] URL Request 생성을 담당하는 객체 구현 [Issue][issue42] [PR][pr54]
* [Heidi] 숙소 검색 결과 뷰모델 구현 [Issue][issue71] [PR][pr74]
* [Jason] NetworkDispatcher 구현 [Issue][issue44] [PR][pr78]
* [Jason] BNBsTask 구현 [Issue][issue48] [PR][pr79]
* [Jason] BNBsUseCase 구현 [Issue][issue55] [PR][pr82]
* [Heidi] 리뷰 피드백 반영 [Issue][issue77] [PR][pr80]
* [Jason] 리뷰 피드백 반영 [Issue][issue83] [PR][pr85]
* [Heidi] 스토리보드로 컬렉션 뷰 커스텀 셀 구성 [Issue][issue70] [PR][pr87]
* [Jason] Image Cache, Image UseCase 구현 [Issue][issue86] [PR][pr93]
* [Pair] UseCase, ViewModel, VC 연결 및 셀에 데이터 디스플레이 [Issue][issue97] [PR][pr100]
* [Heidi] Networking Layer 테스트 개선 [Issue][issue107] [PR][pr118]

**실행 결과**

> 메인 화면  

![airbnb_search](https://user-images.githubusercontent.com/38216027/87530001-bc1e0980-c6ca-11ea-8011-b157cca354fb.gif)

> 슬라이드 

![airbnb_slide](https://user-images.githubusercontent.com/38216027/87528949-3c436f80-c6c9-11ea-8443-c04367290144.gif)

> 이미지 다운로드 후 업데이트 

![airbnb_image_update](https://user-images.githubusercontent.com/38216027/87529357-dc00fd80-c6c9-11ea-940a-a4adf89f3c0c.gif)



### 로그인 기능 구현

> [PR #129 [iOS] 로그인 기능을 구현][pr129]

* [Jason] 로그인 화면 구성 [Issue][issue103] [PR][pr105]
* [Jason] GitHub OAuth인증 및 JWT 토큰 저장 기능 구현 [Issue][issue104] [PR][pr112]
* [Jason] 조건에 따라 로그인 화면 띄우는 기능 구현 [Issue][issue113] [PR][pr127]


**실행 결과**

![login](https://user-images.githubusercontent.com/38216027/87535171-05be2280-c6d2-11ea-93bc-a19675b7e198.gif)

### 가격 선택 기능 구현

> 숙박 가격 선택 기능 구현

* [Jason] 가격 화면 텍스트 부분 구현 [Issue][issue132] [PR][pr165]
* [Jason] 가격 화면의 커스텀 슬라이더 구현 [Issue][issue137] [PR][pr166]
* [Jason] 가격 화면 그래프 구현 [Issue][issue144] [PR][pr167]
* [Jason] 가격 화면 초기화 기능 구현 [Issue][issue146] [PR][pr168]
* [Jason] 가격 완료 버튼 기능 구현 [Issue][issue148] [PR][pr169]



**실행 결과**

> 가격 화면

![price](https://user-images.githubusercontent.com/38216027/87530646-92b1ad80-c6cb-11ea-8a98-563e1ce0cccf.gif)

> 가격 초기화 

![price_clear](https://user-images.githubusercontent.com/38216027/87530953-fd62e900-c6cb-11ea-8de8-a7f27fe17ff4.gif)

> 가격을 기준으로 필터 

![price_complete](https://user-images.githubusercontent.com/38216027/87531819-394a7e00-c6cd-11ea-8109-48457192fbf3.gif)


[spreadsheet]: https://docs.google.com/spreadsheets/d/1mEWSSgX4h4rGINgtG6D2y6Qk0B0QxjHbdrxlQimck3Y/edit?usp=sharing

[issue3]: https://github.com/codesquad-member-2020/airbnb-02/issues/3
[issue5]: https://github.com/codesquad-member-2020/airbnb-02/issues/5
[issue6]: https://github.com/codesquad-member-2020/airbnb-02/issues/6
[issue7]: https://github.com/codesquad-member-2020/airbnb-02/issues/7
[issue8]: https://github.com/codesquad-member-2020/airbnb-02/issues/8
[issue11]: https://github.com/codesquad-member-2020/airbnb-02/issues/11
[issue14]: https://github.com/codesquad-member-2020/airbnb-02/issues/14
[issue15]: https://github.com/codesquad-member-2020/airbnb-02/issues/15
[issue27]: https://github.com/codesquad-member-2020/airbnb-02/issues/27
[issue30]: https://github.com/codesquad-member-2020/airbnb-02/issues/30
[issue34]: https://github.com/codesquad-member-2020/airbnb-02/issues/34
[issue40]: https://github.com/codesquad-member-2020/airbnb-02/issues/40
[issue42]: https://github.com/codesquad-member-2020/airbnb-02/issues/42
[issue43]: https://github.com/codesquad-member-2020/airbnb-02/issues/43
[issue44]: https://github.com/codesquad-member-2020/airbnb-02/issues/44
[issue48]: https://github.com/codesquad-member-2020/airbnb-02/issues/48
[issue49]: https://github.com/codesquad-member-2020/airbnb-02/issues/49
[issue55]: https://github.com/codesquad-member-2020/airbnb-02/issues/55
[issue61]: https://github.com/codesquad-member-2020/airbnb-02/issues/61
[issue70]: https://github.com/codesquad-member-2020/airbnb-02/issues/70
[issue71]: https://github.com/codesquad-member-2020/airbnb-02/issues/71
[issue77]: https://github.com/codesquad-member-2020/airbnb-02/issues/77
[issue83]: https://github.com/codesquad-member-2020/airbnb-02/issues/83
[issue86]: https://github.com/codesquad-member-2020/airbnb-02/issues/86
[issue97]: https://github.com/codesquad-member-2020/airbnb-02/issues/97
[issue107]: https://github.com/codesquad-member-2020/airbnb-02/issues/107
[issue103]: https://github.com/codesquad-member-2020/airbnb-02/issues/103
[issue104]: https://github.com/codesquad-member-2020/airbnb-02/issues/104
[issue113]: https://github.com/codesquad-member-2020/airbnb-02/issues/113
[issue132]: https://github.com/codesquad-member-2020/airbnb-02/issues/132
[issue137]: https://github.com/codesquad-member-2020/airbnb-02/issues/137
[issue144]: https://github.com/codesquad-member-2020/airbnb-02/issues/144
[issue146]: https://github.com/codesquad-member-2020/airbnb-02/issues/146
[issue148]: https://github.com/codesquad-member-2020/airbnb-02/issues/148

[pr4]: https://github.com/codesquad-member-2020/airbnb-02/pull/4
[pr12]: https://github.com/codesquad-member-2020/airbnb-02/pull/12
[pr16]: https://github.com/codesquad-member-2020/airbnb-02/pull/16
[pr20]: https://github.com/codesquad-member-2020/airbnb-02/pull/20
[pr22]: https://github.com/codesquad-member-2020/airbnb-02/pull/22
[pr23]: https://github.com/codesquad-member-2020/airbnb-02/pull/23
[pr25]: https://github.com/codesquad-member-2020/airbnb-02/pull/25
[pr28]: https://github.com/codesquad-member-2020/airbnb-02/pull/28
[pr35]: https://github.com/codesquad-member-2020/airbnb-02/pull/35
[pr37]: https://github.com/codesquad-member-2020/airbnb-02/pull/37
[pr38]: https://github.com/codesquad-member-2020/airbnb-02/pull/38
[pr46]: https://github.com/codesquad-member-2020/airbnb-02/pull/46
[pr53]: https://github.com/codesquad-member-2020/airbnb-02/pull/53
[pr54]: https://github.com/codesquad-member-2020/airbnb-02/pull/54
[pr56]: https://github.com/codesquad-member-2020/airbnb-02/pull/56
[pr57]: https://github.com/codesquad-member-2020/airbnb-02/pull/57
[pr62]: https://github.com/codesquad-member-2020/airbnb-02/pull/62
[pr74]: https://github.com/codesquad-member-2020/airbnb-02/pull/74
[pr78]: https://github.com/codesquad-member-2020/airbnb-02/pull/78
[pr79]: https://github.com/codesquad-member-2020/airbnb-02/pull/79
[pr80]: https://github.com/codesquad-member-2020/airbnb-02/pull/80
[pr82]: https://github.com/codesquad-member-2020/airbnb-02/pull/82
[pr85]: https://github.com/codesquad-member-2020/airbnb-02/pull/85
[pr87]: https://github.com/codesquad-member-2020/airbnb-02/pull/87
[pr93]: https://github.com/codesquad-member-2020/airbnb-02/pull/93
[pr100]: https://github.com/codesquad-member-2020/airbnb-02/pull/100
[pr105]: https://github.com/codesquad-member-2020/airbnb-02/pull/105
[pr112]: https://github.com/codesquad-member-2020/airbnb-02/pull/112
[pr118]: https://github.com/codesquad-member-2020/airbnb-02/pull/118
[pr119]: https://github.com/codesquad-member-2020/airbnb-02/pull/119
[pr127]: https://github.com/codesquad-member-2020/airbnb-02/pull/127
[pr129]: https://github.com/codesquad-member-2020/airbnb-02/pull/129
[pr165]: https://github.com/codesquad-member-2020/airbnb-02/pull/165
[pr166]: https://github.com/codesquad-member-2020/airbnb-02/pull/166
[pr167]: https://github.com/codesquad-member-2020/airbnb-02/pull/167
[pr168]: https://github.com/codesquad-member-2020/airbnb-02/pull/168
[pr169]: https://github.com/codesquad-member-2020/airbnb-02/pull/169