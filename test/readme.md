# k8s上脚本类代码热更新

对于脚本类的代码的更新，比如 Python、Lua、PHP，在虚拟机时代，通常我们我们都会将源码拷贝到虚拟机上，替换掉原有代码，然后通过 restart 一类的热更新命令将旧的代码进程替换成新的。那么在k8s上我们是否也可以这么做呢？答案是肯定的，核心就是利用k8s上的pvc的灵活挂载来实现文件替换，这里介绍两种方式: 基于git runner 的CICD自动化更新和基于运维手动管理更新。

1. 使用 nas 用于存储和管理运行代码，设置storageclass，可以让需要用到这份脚本的pod都通过storageclass声明到同一个NAS存储位置上。配置如下：
[图片](./uml.jpg)
操作步骤可以见：https://www.volcengine.com/docs/6460/101638

2. 配置一个jupyter的pod，提供 web 界面做预览，运维可以通过界面更方便管理.

3. 通过web界面访问：
[](./log.png)
[](./jupyter-home.png)

4. 创建一个外网ingress绑定上workload即可，如果没有用Ingress，可以通过port-forward的方式映射到本地访问。