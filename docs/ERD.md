# 📌 엔터티 간 관계 다이어그램 (N:N)

## 🔷 엔터티 정의
- **Category**
  - **속성:**
    - `name`: 카테고리의 이름 (고유, 중복 불가)
    - `red`: 색상(RGB)에서 빨간색 구성 요소 값 (0 ~ 255)
    - `green`: 색상(RGB)에서 초록색 구성 요소 값 (0 ~ 255)
    - `blue`: 색상(RGB)에서 파란색 구성 요소 값 (0 ~ 255)
  - **관계:**
    - `diaries`: 여러 `Diary`와 연결 (다대다 관계)

- **Diary**
  - **속성:**
    - `title`: 다이어리의 제목
    - `content`: 다이어리의 내용
    - `createdDate`: 생성일
  - **관계:**
    - `categories`: 여러 `Category`와 연결 (다대다 관계)

---

## 🔷 관계 설명 (N:N)
- **N:N (다대다) 관계:**
  - 각 `Category`는 여러 `Diary`에 연결될 수 있으며, 각 `Diary`도 여러 `Category`에 연결될 수 있습니다.

### 📌 Category → Diary:
- 각 카테고리는 여러 다이어리를 참조할 수 있으며, 다이어리 삭제 시 해당 참조는 **무효화(nullify)** 됩니다.

### 📌 Diary → Category:
- 각 다이어리는 여러 카테고리를 참조할 수 있으며, 카테고리 삭제 시 해당 참조는 **무효화(nullify)** 됩니다.

---

## 🔷 관계 다이어그램 (ERD)

```mermaid
+───────────────+            +───────────────+
|   Category    | *        * |    Diary      |
|───────────────|<–––––----->|───────────────|
| - name        |            | - title       |
| - red         |            | - content     |
| - green       |            | - createdDate |
| - blue        |            |───────────────|
|───────────────|            | + categories  |
| + diaries     |            |               |
+───────────────+            +───────────────+
```


---

## 🔷 실제 코드 (SwiftData)

```swift
@Model
final class Category {
    /// 카테고리의 고유 이름을 나타내는 속성입니다.
    /// - Note: 각 카테고리의 이름은 중복될 수 없으며, 고유해야 합니다.
    @Attribute(.unique) var name: String
    /// 카테고리의 색상에서 빨간색(Red) 구성 요소 값 (0 ~ 255)입니다.
    private var red: Double
    /// 카테고리의 색상에서 초록색(Green) 구성 요소 값 (0 ~ 255)입니다.
    private var green: Double
    /// 카테고리의 색상에서 파란색(Blue) 구성 요소 값 (0 ~ 255)입니다.
    private var blue: Double

    /// 카테고리를 적용한 다이어리를 나타내는 속성입니다.
    /// - Note: 다이어리가 삭제될 경우, 카테고리에서 해당 다이어리에 대한 참조를 무효화합니다. (nullify)
    @Relationship(deleteRule: .nullify) var diaries: [Diary] = []

    /// 카테고리의 색상을 반환하는 계산된 속성입니다.
    /// - Returns: RGB 값을 기반으로 생성된 Color 객체
    var color: Color {
        .init(r: red, g: green, b: blue)
    }

    /// 카테고리 모델의 초기화 메서드입니다.
    /// - Parameters:
    ///   - name: 카테고리의 고유 이름
    ///   - red: 색상의 빨간색(Red) 값 (0 ~ 255)
    ///   - green: 색상의 초록색(Green) 값 (0 ~ 255)
    ///   - blue: 색상의 파란색(Blue) 값 (0 ~ 255)
    init(name: String, red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0) {
        self.name = name
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    /// 카테고리 모델의 편의 초기화 메서드입니다.
    /// - Parameters:
    ///   - name: 카테고리의 고유 이름
    ///   - color: 카테고리의 색상 (Color 객체)
    /// - Note: Color 객체에서 RGB 값을 추출하여 각 구성 요소(red, green, blue)로 설정됩니다.
    convenience init(name: String, color: Color) {
        let rgb = color.rgbComponents()
        self.init(name: name, red: rgb.red, green: rgb.green, blue: rgb.blue)
    }
}

@Model
final class Diary {
    /// 다이어리의 제목을 나타내는 문자열입니다.
    var title: String
    /// 다이어리의 내용을 나타내는 문자열입니다.
    var contents: String
    /// 다이어리에 연결된 카테고리 목록입니다.
    /// - Note: 카테고리가 삭제될 경우, 다이어리에서 해당 카테고리에 대한 참조를 무효화합니다. (nullify)
    @Relationship(deleteRule: .nullify, inverse: \Category.diaries)
    var categories: [Category]
    /// 다이어리 작성 날짜를 나타내는 Date 객체입니다.
    var createdDate: Date

    /// Diary 모델의 초기화 메서드입니다.
    /// - Parameters:
    ///   - title: 다이어리의 제목
    ///   - contents: 다이어리의 내용
    ///   - categories: 다이어리에 연결할 카테고리 목록
    ///   - date: 다이어리 작성 날짜
    init(title: String, contents: String, categories: [Category], createdDate: Date = .now) {
        self.title = title
        self.contents = contents
        self.categories = categories
        self.createdDate = createdDate
    }
}
```
