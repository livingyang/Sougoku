client: cordova
frameworks: PurchasePlatform

server: meteor
frameworks: coffeescript, underscore, appcache, accounts-password, accounts-ui, stylus, jquery-layout, iron-router, reststop2, meteor-createjs, nprogress, bootstrap-3, csv-to-collection, moment

战斗方式：
1 强攻战，显示敌方血量，每攻击一次敌方，可减少敌方血量
2 防御战，显示敌方攻击力，是否成功的概率为：我方血量 / 敌方攻击力，每一次失败的防御都会增加下一次防御的成功概率
3 卡牌有两种技能，分别为加攻技能，加血技能，战斗过程中几率触发
4 特定卡牌组合有称为Combo，将增加攻击力，或者血量百分比
