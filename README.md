# TYGPlaceholderHelper
借鉴[DRImagePlaceholderHelper](https://github.com/albertschulz/DRImagePlaceholderHelper)写的一个placeholderImage工具    
使用TYGPlaceholderHelper能让你较方便的生成等待图片，如下：    

![](Screenshot.png?raw=true)

# 使用方法
首先，得引用头文件    
```objective-c
	#import "TYGPlaceholderHelper.h"
```

获取一个placeholder image:(100x100)    

```objective-c
	UIImage *placeholderImage = [[TYGPlaceholderHelper sharedInstance] placeholderImageWithSize:CGSizeMake(100,100)];
```

或者 fill a UIImageView     

```objective-c
	[imageView fillWithPlaceholderImage]; 
```

也有选项来定制填充颜色和文本内部的图像，可以看看示例项目以获取更多信息。
