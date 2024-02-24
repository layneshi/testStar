
// ToDoList
1.微信登录api已经接入 需要服务器部署支持https domain  。 apple-app-site-association文件在code文件Tool目录下
2.一键登录集成 极光推送已经集成
3.等后端接口返回reportId后续接入 获取模板选择  发送给谁，接口已写等联调  接口参照WHApiLists  WHWearTimeApi
4.一些高保真的UI修改






选择的项目清单模型 ：



健康数据获取参考 WHGetHealthyKit 类  订的协议是每次启动App的时候上传健康数据到后台
跟后端接口对的数据类型参考 WHReportModel类

1.心电图可以拿到数组，每个数组中可以拿到对应的心率和赫兹用于绘制心电图
- (void)getECG:(void(^)(double value, NSError *error))completion 



swagger地址 ： http://192.168.124.54:8080/swagger-ui/#/%E4%BD%93%E6%A3%80%E6%8A%A5%E5%91%8A%E6%8E%A5%E5%8F%A3/scheduledUsingPOST

高保证地址: https://t3e0g1.axshare.com/#id=83puwe&p=%E4%B8%AA%E4%BA%BA%E8%B5%84%E6%96%99&g=1
蓝湖原型图 : https://lanhuapp.com/web/#/item/project/detailDetach?pid=ec390ee1-28fd-4139-8cfb-60aa9de04c0f&project_id=ec390ee1-28fd-4139-8cfb-60aa9de04c0f&image_id=6d7f63ca-e89e-




