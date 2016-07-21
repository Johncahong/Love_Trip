//
//  Address.h
//  1516网络-蔡耿鸿
//
//  Created by Hello Cai on 16/3/25.
//  Copyright © 2016年 Hello Cai. All rights reserved.
//

#ifndef Address_h
#define Address_h

//发现首页：
//http://chanyouji.com/api/trips/featured.json?page=1
#define FAXian_URL @"http://chanyouji.com/api/trips/featured.json?page=%d"


//发现cell详情：
//http://chanyouji.com/api/trips/306639.json
#define FAXianDetail_URL @"http://chanyouji.com/api/trips/%@.json"


//攻略首页：
//http://chanyouji.com/api/destinations.json
#define GongLue_URL @"http://chanyouji.com/api/destinations.json"

//攻略cell详情：
//http://chanyouji.com/api/destinations/55.json?page=1
#define GongLueDetail_URL @"http://chanyouji.com/api/destinations/%@.json?page=1"


//--------------------
//攻略cell中的行程（第二个button）：
//http://chanyouji.com/api/destinations/plans/55.json?page=1
#define GL_XingCheng2_URL @"http://chanyouji.com/api/destinations/plans/%@.json?page=1"

//行程的详情：
//http://chanyouji.com/api/plans/1628.json
#define GL_XC_Detail_URL @"http://chanyouji.com/api/plans/%@.json"


//--------------------
//攻略cell中的旅行地（第三个button）：
//http://chanyouji.com/api/destinations/attractions/55.json?per_page=20&page=1
#define GL_LvXingDi3_URL @"http://chanyouji.com/api/destinations/attractions/%@.json?per_page=20&page=%d"

//旅行地详情：
//http://chanyouji.com/api/attractions/35443.json
#define GL_LXD_Detail_URL @"http://chanyouji.com/api/attractions/%@.json"

//--------------------
//搜索http://chanyouji.com/api/wiki/destinations.json
#define KSearchURL @"http://chanyouji.com/api/wiki/destinations.json"

//搜索详情
#define KSearchDetailURL @"http://chanyouji.com/api/search/trips.json?"

#endif /* Address_h */
