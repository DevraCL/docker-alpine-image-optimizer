Just do a:
```
docker run -ti --rm -v `pwd`:/images scher200/alpine-image-optimizer
```
in the directory (recursive) you want to optimize (JPG, PNG AND GIF)

Alternative in the background:
```
nohup docker run -i --rm -v `pwd`:/images scher200/alpine-image-optimizer &
```

Or a cronjob:
```
0 0 * * *  docker run -i --rm -e DAYS_YOUNG=1 -v /path/to/images:/images scher200/alpine-image-optimizer >> /var/log/image-optimizer.log & 
```


Possible environment variables:
```
    JPEG_LEVEL: 50    # 30 - 100 JPEG COMPRESSION LEVEL
    NO_PNG_STRIP: 1   # CREATING THIS ENV SET NO PNG STRIPPING
    DAYS_YOUNG: 7     # CREATING THIS ENV SETS THE NUMBER OF DAYS IN TIME TOO LOOK BACK FOR IMAGES TO HANDLE
```

