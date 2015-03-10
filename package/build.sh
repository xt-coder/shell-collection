cd /home/project/js

echo " ====> 更新manage js项目开始 ..."

echo " ====> 项目更新中 ..."

rm ./V/package.json

svn up --username school --password school https://192.168.1.254/svn/make/V V

echo " =====>更新配置文件"
rm ./V/package.json
rm -rf ./V/stjs/v-modules/v-web/classGroup
cp ./school_cms.json ./V/package.json

echo " ====> 项目编译打包中 ..."
cd V
grunt build-js --force
grunt build-relatecss

path="/home/static/resources/stjs/v-modules/release/v/school_cms"
back=$path"/backup/`date +%G_%m_%d_%H_%M_%S`"
mkdir $back
mv /home/static/resources/stjs/vko-modules/release/v/school_cms $back

#backcss ="/home/static/resources/stcss/release/v/school_cms_`date +%G_%m_%d_%H_%M_%S`.css"
mv /home/static/resources/stcss/release/v/school_cms.css /home/static/resources/stcss/release/v/school_cms_`date +%G_%m_%d_%H_%M_%S`.css


echo " ====> 开始拷贝最新的js css文件到发布目录 ..."
cd ..
rm -rf /home/static/resources/stjs/v-modules/release/v/school_cms/*.js
#rm -rf /home/static/resources/stjs/v-modules/release/v/school_cms/common/*
cp ./V/stjs/release/v/school_cms/*.js  /home/static/resources/stjs/v-modules/release/v/school_cms/
#cp ./V/stjs/release/v/school_cms/common/*.js /home/static/resources/stjs/v-modules/release/v/school_cms/common/ 
cp ./V/stcss/release/v-web/school_cms.css /home/static/resources/stcss/release/v/school_cms.css

echo " ====> 主人,项目部署完毕了 ..."

exit 0
