# 부기날씨 (hansungcapstone_bugiweather)

2024년도 한성대학교 캡스톤디자인 작품으로 제작된 Flutter 날씨/대기질 앱입니다. 현재 위치 기반으로 단기·중기 날씨 예보와 대기질(미세먼지) 정보를 보여주고, 네이버맵으로 주요 도시의 날씨를 지도에서 확인할 수 있습니다.

## 실행 화면

![앱 실행 화면](screenshot/loading.png)

## 주요 기능

- 현재 위치 기반 단기예보(초단기/동네예보) 및 3일 예보 표시
- 한성대학교 고정 위치 기준 날씨도 별도로 표시
- 중기예보(3~10일) 표시
- 대기질(미세먼지/초미세먼지 등) 실시간 측정 정보 표시
- 네이버맵 기반 전국 주요 도시별 날씨 지도

## 기술 스택

- Flutter / Dart
- `flutter_naver_map` — 네이버맵 SDK
- `geolocator` — 현재 위치(GPS) 조회
- `http` — REST API 호출
- `flutter_dotenv` — `.env` 기반 API 키 관리
- `permission_handler` — 위치 권한 처리

## 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점, .env 로드
├── apploading.dart           # 최초 로딩 화면 - 위치/날씨/중기예보 데이터 취합
├── screen.dart                # 메인 홈 화면(탭) - 오늘/주간 날씨, 대기질
├── todayweatherscreen.dart    # 오늘 날씨 화면
├── weekscreen.dart            # 주간 예보 화면
├── hstodayweatherscreen.dart  # 한성대 위치 기준 날씨 화면
├── dust.dart                  # 대기질(미세먼지) 화면
├── favorites.dart             # 즐겨찾기 화면
├── setting.dart               # 설정 화면
├── network.dart / httpnetwork.dart  # 공공데이터포털/OpenWeatherMap 호출
├── model.dart                 # 공통 데이터 모델
└── NaverMap/                  # 네이버맵 화면 및 관련 로직
    ├── main.dart, NaverMapApp.dart, network.dart, mylocation.dart
    └── screens/loading.dart   # 네이버맵 로딩/초기화
```

## 실행 방법

이 앱은 아래 5개의 외부 API 키/ID가 있어야 정상 동작합니다. 보안상 저장소에는 실제 키를 포함하지 않으므로, 직접 발급받아 프로젝트 루트에 `.env` 파일을 만들어야 합니다. `.env.example`을 참고해서 아래처럼 작성하세요. (`.env`는 `.gitignore`에 등록되어 커밋되지 않습니다)

```
apiKey=공공데이터포털_단기예보_서비스키
kakao_api=카카오_API_키
openweather_api_key=OpenWeatherMap_API_키
mid_fcst_api_key=공공데이터포털_중기예보_서비스키
naver_client_id=네이버클라우드플랫폼_Maps_클라이언트ID
```

| 키 | 발급처 | 용도 |
| --- | --- | --- |
| `apiKey` | [공공데이터포털](https://www.data.go.kr) - 단기예보/대기오염정보 API | 동네예보, 대기질 조회 |
| `kakao_api` | [카카오 디벨로퍼스](https://developers.kakao.com) | 좌표 변환(WGS84 → TM) |
| `openweather_api_key` | [OpenWeatherMap](https://home.openweathermap.org/api_keys) | One Call API (도시별 날씨) |
| `mid_fcst_api_key` | [공공데이터포털](https://www.data.go.kr) - 중기예보 API | 중기예보(3~10일) |
| `naver_client_id` | [네이버 클라우드 플랫폼](https://www.ncloud.com) | 네이버맵 SDK 인증 |

설치 후:

```bash
flutter pub get
flutter build apk --debug
```

### 참고: 네이버맵 SDK 저장소

`flutter_naver_map` 패키지(1.2.1)가 참조하는 구 Maven 저장소(`naver.jfrog.io`)가 현재 서비스 종료되어 있습니다. 빌드 시 `zip END header not found` 오류가 나면, 로컬 pub cache의 `flutter_naver_map-1.2.1/android/build.gradle`에서 저장소 URL을 `https://repository.map.naver.com/archive/maven`로 바꿔주세요.
