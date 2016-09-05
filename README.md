# KINScaleCalculator
adjust scale for iOS Device

# using
pod 'KINScaleCalculator'

# enum DeviceType

case IPHONE_320_480 // iPhone 4s

case IPHONE_320_568 // iPhone 5, iPhone 5s

case IPHONE_375_667 // iPhone 6, iPhone 6s

case IPHONE_414_736 // iPhone 6+, iPhone 6s+

case IPAD_768_1024 // iPad

case IPAD_1024_1366 // iPad Pro

case ELSE


# init

- init(device:DeviceType)
- 개발용 기준 해상도 지정
- ex : let scale = ScaleCalculator(IPHONE_320_480)

# func
- func rect(rect:CGRect) -> CGRect
- 실행되는 디바이스의 가로 해상도에 맞추어 변환한 CGRect 반환
- ex : let newFrame = scale.rect(CGRectMake(10,10,200,200))

- func rect(rect:CGRect, adjustHeight) -> CGRect
- 실행되는 디바이스의 가로 해상도에 맞추어 변환한 CGRect 반환, adjustHeight 값이 true인 경우 화면의 높이값에도 영향을 받는다
- ex : let newFrame = scale.rect(CGRectMake(10,10,200,200), adjustHeight:true)

- func size(size:CGSize) -> CGSize
- 실행되는 디바이스의 가로 해상도에 맞추어 변환한 CGSize 반환
- ex : let newSize = scale.size(CGSizeMake(200,200))

- func size(size:CGSize) -> CGSize
- 실행되는 디바이스의 가로 해상도에 맞추어 변환한 CGSize 반환, adjustHeight 값이 true인 경우 화면의 높이값에도 영향을 받는다
- ex : let newSize = scale.size(CGSizeMake(200,200), adjustHeight:true)

- func point(point:CGPoint) -> CGPoint
- 실행되는 디바이스의 가로 해상도에 맞추어 변환한 CGPoint 반환
- ex : let newPoint = scale.point(CGPointMake(10,10))

- func point(point:CGPoint) -> CGPoint
- 실행되는 디바이스의 가로 해상도에 맞추어 변환한 CGPoint 반환, adjustHeight 값이 true인 경우 화면의 높이값에도 영향을 받는다
- ex : let newPoint = scale.point(CGPointMake(10,10), adjustHeight:true)

- func view(view:UIView)
- 실행되는 디바이스의 가로 해상도에 맞추어 뷰의 프레임을 변경
- ex : scale.view(self.view)

- func view(view:UIView)
- 실행되는 디바이스의 가로 해상도에 맞추어 뷰의 프레임을 변경, adjustHeight 값이 true인 경우 화면의 높이값에도 영향을 받는다
- ex : scale.view(self.view, adjustHeight:true)