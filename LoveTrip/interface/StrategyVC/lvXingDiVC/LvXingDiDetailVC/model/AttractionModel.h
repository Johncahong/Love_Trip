//
//  AttractionModel.h
//  LoveTrip
//
//  Created by Hello Cai on 16/4/9.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttractionModel : NSObject

//"id": 9316,
//"description": "#京都的名片# 清水寺与金阁寺、岚山等同为京都境内最著名的名胜古迹，一年四季前来朝拜的香客或来访的观光客是络驿不绝。 清水寺是京都最古老的寺院，建于公元798年，清水寺的山号为音羽山，主要供奉千手观音。",
//"updated_at": 1389873224,
//"node_id": 713048,
//"node_comments_count": 0,
//"trip": {
//    "id": 93844,
//    "name": "京都红叶狩",
//    "photos_count": 123,
//    "days": 4,
//    "start_date": "2013-11-28",
//    "end_date": "2013-12-01",
//    "level": 3,
//    "privacy": false,
//    "views_count": 5344,
//    "comments_count": 8,
//    "likes_count": 95,
//    "state": "publish",
//    "source": "web",
//    "serial_id": null,
//    "serial_position": null,
//    "front_cover_photo_url": "http://cyj.qiniudn.com/93844/1388465555906p18d3et14ihcf6n1jmjaac1qmj2v.jpg",
//    "updated_at": 1408616705,
//    "user": {
//        "id": 34757,
//        "name": "芒椰西米",
//        "image": "http://tp2.sinaimg.cn/1849354581/180/5671970414/0"
//    }
//},
//"notes": [
//          {
//              "id": 3684607,
//              "description": "",
//              "width": 1600,
//              "height": 900,
//              "photo_url": "http://p.chanyouji.cn/93844/1388465098531p18d3et14i1gg7o6a3u8t3r10el1t.jpg",
//              "video_url": null
//          },
//          {
//              "id": 3684578,
//              "description": "红叶簇拥的清水舞台",
//              "width": 1600,
//              "height": 1200,
//              "photo_url": "http://p.chanyouji.cn/93844/1388464746265p18d3et14i2k01njm13opg2c39n10.jpg",
//              "video_url": null
//          },
//          {
//              "id": 3684579,
//              "description": "清水寺三重塔",
//              "width": 1600,
//              "height": 1200,
//              "photo_url": "http://p.chanyouji.cn/93844/1388464753718p18d3et14i1hgdq16l6f1cgb17fb11.jpg",
//              "video_url": null
//          }
//          ]
//},
//{
//    "id": 9308,
//    "description": "#栋梁结构式寺院# 大殿前为悬空的“舞台”，由139根高数十米的大圆木支撑。寺院建筑气势宏伟，结构巧妙，未用一根钉子。",
//    "updated_at": 1389873636,
//    "node_id": 221229,
//    "node_comments_count": 0,
//    "trip": {
//        "id": 27528,
//        "name": "那些天，京都的人和事 (上) ",
//        "photos_count": 90,
//        "days": 3,
//        "start_date": "2012-12-29",
//        "end_date": "2012-12-30",
//        "level": 3,
//        "privacy": false,
//        "views_count": 2539,
//        "comments_count": 5,
//        "likes_count": 43,
//        "state": "publish",
//        "source": "web",
//        "serial_id": null,
//        "serial_position": null,
//        "front_cover_photo_url": "http://p.chanyouji.cn/27528/1362799646294p17l6i7ab8ig2dss1a341s3818ps1s.jpg",
//        "updated_at": 1401742994,
//        "user": {
//            "id": 17036,
//            "name": "kyoka",
//            "image": "http://img3.douban.com/icon/ul2239749-1.jpg"
//        }
//    },
//    "notes": [
//              {
//                  "id": 878639,
//                  "description": "清水寺为栋梁结构式寺院。正殿宽19米，进深16米，大殿前为悬空的“舞台”，由139根高数十米的大圆木支撑。寺院建筑气势宏伟，结构巧妙，未用一根钉子。寺中六层炬木筑成的木台为日本所罕有。",
//                  "width": 1600,
//                  "height": 1067,
//                  "photo_url": "http://p.chanyouji.cn/27528/1362799131782p17l6i7ab814ur19561iuk1fdb1ndvp.jpg",
//                  "video_url": null
//              },
//              {
//                  "id": 878632,
//                  "description": "",
//                  "width": 1600,
//                  "height": 1067,
//                  "photo_url": "http://p.chanyouji.cn/27528/1362799010440p17l6i7ab71tl610qj142f181s1g02j.jpg",
//                  "video_url": null
//              }
//              ]
//},


//需要用的关键字trip[start_date]   trip[user][name]  trip[user][nodes]
@property(nonatomic,copy)NSString *idStr;
@property(nonatomic,copy)NSString *descriptionStr;
@property(nonatomic,strong)NSDictionary *trip;
@property(nonatomic,strong)NSMutableArray *notes;


@end
