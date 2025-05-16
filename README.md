

<h1 align="center">

   

<p align="center">
  <img src="./docs/ScreenShots/온보딩 영상.gif" width="250px">

</p>

<h4 align="center">감성 다이어리 iOS 앱 – 일상을 기록하고 통계를 통해 돌아보세요.</h4>
<p align="center">
  <a href="https://swift.org">
    <img src="https://img.shields.io/badge/Swift-6.0-orange?logo=swift" alt="Swift Version" />
  </a>
  <a href="https://github.com/rlarjsdn3/EST-2th-Team2-Project/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/rlarjsdn3/EST-2th-Team2-Project?color=blue" alt="Contributors" />
  </a>
  <br/>
  <a href="https://github.com/rlarjsdn3/EST-2th-Team2-Project" style="text-decoration:none; font-size:14px; color:#0366d6;">
    GitHub 프로젝트 바로가기
  </a>
</p>





## 📔 OurCampDiary란?
**OurCampDiary**는 사용자가 감성적으로 일상을 기록하고, 카테고리와 통계 기능을 통해 회고와 분석이 가능하도록 설계된 **iOS 다이어리 앱**입니다.





## 📌 주요 기능
- ✍️ 다이어리 작성, 수정, 삭제 및 카테고리 지정  
- 📅 다이어리 리스트 및 검색 (제목, 내용, 전체 검색)  
- 🔍 필터링 및 정렬 (최신순/과거순, 카테고리별)  
- 🏷️ 카테고리 생성, 수정, 삭제 (기본 카테고리 자동 생성 포함)  
- 📊 주간 및 월간 통계 (카테고리별 차트 제공)  




## ✅ 요구사항

### 📋 기능 요구사항(Functional Requirements)

| 화면        | 요구사항                                                         |
|-------------|------------------------------------------------------------------|
| 📱 온보딩 화면   | 앱 최초 실행 시 FullScreenCover로 튜토리얼 표시                        |
| 🏠 홈화면      | 다이어리 최신순 정렬 / 작성 버튼 및 수정·삭제 기능                     |
| 🔍 검색화면    | 제목/내용 기반 필터링 및 최신순 정렬                                     |
| ✍️ 글 작성 화면 | 제목·내용 입력 및 수정 / 카테고리 지정 가능                            |
| 🏷️ 카테고리 화면 | 카테고리 생성, 이름·색상 수정, 삭제 가능                              |
| 📊 통계화면    | 주간/월간 기준 카테고리별 통계를 원형 차트로 시각화                     |
| ⚙️ 설정화면    | 카테고리 설정 및 문의 메일 전송 가능                                     |
| 🔄 공통        | 탭바 및 네비게이션바 통한 뷰 전환 기능 제공                             |

### 🛠️ 비기능 요구사항(Non-Functional Requirements)

| 🛠️ 비기능 요구사항      | 상세 설명                                      |
|-------------------------|-----------------------------------------------|
| 🌙 다크 모드 지원        | 시스템 다크 모드에 맞춰 UI 색상 및 스타일 자동 조정      |
| 📱 아이패드 레이아웃 대응 | 아이패드 가로/세로 모드에 맞는 유연한 UI 레이아웃 구현      |
| 💾 설정 데이터 저장      | `UserDefaults` 및 `@AppStorage` 활용하여 사용자 설정 유지   |
| 🗃️ 데이터 저장소         | 회고 데이터는 `SwiftData` 또는 `CoreData` 기반으로 관리     |
| 🔤 큰 폰트 지원          | 큰 폰트 설정 시에도 UI 요소 깨짐 없이 정상 표시              |
| 🛡️ 안정성               | 메모리 누수 방지 및 옵션 처리 시 예외 상황 대응               |

---

## 📦 기술 스택

<!-- 사용한 라이브러리 명시 -->
- SwiftUI
- SwiftData / CoreData



## 📁 폴더 구조

```swift
📁 ProjectRoot
├ 📁 Core                       
│   ├ 📁 CommonViewControllers  (공통으로 사용하는 뷰 컨트롤러)
│   │   └ 📝 MailComposeViewController.swift  
│   ├ 📁 CommonViews           (공통 UI 컴포넌트)
│   │   ├ 📝 CategoryButton.swift        
│   │   ├ 📝 CustomTextField.swift         
│   │   └ 📝 RoundedRectButton.swift       
│   ├ 📁 FloatingSheet          
│   │   └ 📁 Extensions
│   │       └ 📝 FloatingSheet.swift       
│   ├ 📁 Layout               
│   │   └ 📝 ChipLayout.swift              ( 칩 스타일 레이아웃)
│   ├ 📁 Modifiers          
│   │   └ 📝 DefaultShadow+Modifier.swift  ( 기본 그림자 Modifier)
│   ├ 📁 Protocols         
│   │   └ 📝 KeyboardReadable.swift         
│   ├ 📁 Resources             
│   │   ├ 📝 AppColors.swift           (  앱 공통 색상 정의)
│   │   └ 📁 Assets.xcassets                
│   ├ 📁 RetrospectiveNavigationStack  ( 네비게이션 스택 관련 커스텀 구현)
│   │   ├ 📁 Extensions
│   │   │   └ 📝 View+RetrospectiveNavigationStack.swift 
│   │   ├ 📁 PreferenceKeys
│   │   │   ├ 📝 LeadingToolBarPreferenceKey.swift
│   │   │   ├ 📝 NavigationBarColorPreferenceKey.swift
│   │   │   ├ 📝 NavigationBarHeightPreferenceKey.swift
│   │   │   ├ 📝 NavigationTitlePreferenceKey.swift
│   │   │   └ 📝 TrailingToolBarPreferenceKey.swift
│   │   ├ 📝 RetrospectiveNavigationStack.swift  
│   │   ├ 📝 RetrospectiveToolBarItem.swift       
│   │   └ 📝 ToolBarLayout.swift                   
│   ├ 📁 Storage              (데이터 저장 및 관리)
│   │   ├ 📁 AppStorage       
│   │   │   ├ 📝 AppStorage+Extension.swift
│   │   │   ├ 📝 AppStorageKey.swift
│   │   │   └ 📝 AppStorageKeys.swift
│   │   └ 📁 SwiftData      
│   │       └ 📝 PersistenceManager.swift
│   └ 📁 Styles               
│       └ 📝 CustomTextEditorStyle.swift

├ 📁 Models                  ( 메인 데이터 모델)
│   └ 📝 RetrospectiveApp.swift  

├ 📁 Utils                  
│   └ 📁 Extensions          (다양한 확장 메서드 모음)
│       ├ 📝 Array+Extension.swift
│       ├ 📝 Color+Extension.swift
│       ├ 📝 Date+Extension.swift
│       ├ 📝 ModelContext+Extension.swift
│       ├ 📝 Task+Extension.swift
│       ├ 📝 Text+Extension.swift
│       ├ 📝 UIApplication+Extension.swift
│       ├ 📝 UIColor+Extension.swift
│       └ 📝 View+Extension.swift

├ 📁 Views                  
│   ├ 📁 CategoryView        
│   ├ 📁 HomeView            
│   ├ 📁 OnboardingView      
│   ├ 📁 SearchView         
│   ├ 📁 SettingView         
│   ├ 📁 StatisticsView      
│   ├ 📁 WritingView       
│   └ 📝 ContentView.swift    
```

## 📁 주요 뷰 화면
| 🏠 홈 화면 | 🔍검색 화면 | 📊통계 화면 | 🏷️카테고리 화면 |
| :--: | :--: | :--: | :--: | :--: |
| <img src="./docs/ScreenShots/IMG_0354(홈뷰).png" width="250px"> | <img src="./docs/ScreenShots/IMG_0347(검색뷰).png" width="250px"> | <img src="./docs/ScreenShots/IMG_0338.(통계뷰).png" width="250px"> | <img src="./docs/ScreenShots/IMG_0335.(카테고리뷰).png" width="250px"> | 이미지 |





## 👨‍👩‍👧‍👦 기여자

| ![Profile](https://github.com/yourusername.png?size=100) | ![Profile](https://github.com/yourusername.png?size=100) | ![Profile](https://github.com/yourusername.png?size=100) | ![Profile](https://github.com/yourusername.png?size=100) |
| :---: | :---: | :---: | :---: |
| [김건우](https://github.com/rlarjsdn3) | [신유섭](https://github.com/sys97) | [정소이](https://github.com/SoyiJeong) | [노기승](https://github.com/giseungNoh) |

---
