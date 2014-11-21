
cd /home/project/core
./build.sh

echo " ====> 更新module-manage项目开始 ..."

path="/home/project/module/manage"
cd $path
back=$path"/backup/`date +%G_%m_%d_%H_%M_%S`"

echo " ====> 项目更新中 ..."
svn co --username xxx --password xxx https://192.168.1.254/svn/developer/trunk/module-parent/module-manage module-manage
cd module-manage

echo " ====> 项目编译打包中 ..."
mvn clean package install -DskipTests


mv $path"/deploy" $back

echo " ====> 开始解压 module-manage.war ..."

unzip -oq /manage-1.0.0-SNAPSHOT.war -d /home/project/module/manage/deploy

echo " ====> 开始重启manage-module-tomcat中 ..."
cd /home/server/module/manage-module-tomcat/bin
./shutdown.sh
./startup.sh & tail -f ../logs/catalina.out

echo " ====> 主人,项目部署完毕了 ..."