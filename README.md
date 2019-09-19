# GirlPhotos
美女图片

# 接口文档
打开app之前需要获取对应的服务器IP地址，首先获取ip地址，根据接口返回的ip地址，将下面的接口换成对应的ip

每个接口需要传对应的headers
Host:apiv2.prettybeauty.biz
User-Agent : Beauty/1.10 (iPhone; iOS 12.1.2; Scale/2.00)

## 获取服务器ip
接口： http://119.29.29.29/d?dn=apiv2.prettybeauty.biz

## 获取用户ip
接口： https://corn.yumimobi.com/api/getip.php

## 当前用户作品
 示例接口: http://103.85.22.147/girl/detail?app= Fantastic&girl_id=350&it=1552837980&pageIndex=1&pageSize=10&version=1.10
 
## 最热作品
  示例接口: http://103.85.22.147/album/all?app=Fantastic&it=1545917841&pageIndex=1&pageSize=10&styleId=0&type=0&version=1.8
 
## 最新作品
  示例接口: http://103.85.22.147/album/all?app=Fantastic&it=1545917841&pageIndex=1&pageSize=10&styleId=0&type=1&version=1.8
  
## 人气榜
  示例接口: http://103.85.22.147/girl/all?app=Fantastic&it=1552837980&pageIndex=1&pageSize=10&version=1.8 
  
  ![hot](https://github.com/chuheridangwu/GirlPhotos/raw/master/hot.PNG)
  ![latest](https://github.com/chuheridangwu/GirlPhotos/raw/master/latest.PNG)
  ![ranking](https://github.com/chuheridangwu/GirlPhotos/raw/master/ranking.PNG)
  ![userinfo](https://github.com/chuheridangwu/GirlPhotos/raw/master/userinfo.PNG)
  
# 项目中遇到的问题

## 使用占位图片

使用`FadeInImage`部件, kTransparentImage是一个图名图片，导入`transparent_image`,自带渐变效果

```
FadeInImage.memoryNetwork(
  placeholder: kTransparentImage,
  image: 'https://picsum.photos/250?image=9',
);
```

## README.md 添加图片
 
GitHub上面的图片组成路径 github.com/账户名/仓库名/raw/分支名称/图片文件夹(直接放在根目录可忽略)/图片名称 

```
例如我的账号是`chuheridangwu` 仓库为`GirlPhotos`  分支`master`  图片名称`hot.PNG`
![image](https://github.com/chuheridangwu/GirlPhotos/raw/master/hot.PNG)
```
