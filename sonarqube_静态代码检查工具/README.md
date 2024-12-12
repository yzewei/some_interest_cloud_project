静态代码检查工具sonarqube# 工具介绍
SonarQube 是卓越的开源代码质量管理平台。它通过对多种编程语言的深度扫描，精准探测代码漏洞、代码异味、重复代码以及安全热点等。其丰富的插件生态系统可拓展功能，支持与各类开发工具集成，在持续集成/持续交付（CI/CD）流程中无缝嵌入。为开发团队提供详尽报告与可视化界面，助力团队依据数据驱动决策，高效优化代码质量，推动项目稳健前行。 

# 从编译开始
使用语言分析：java
编译工具：gradle
编译命令：bash build.sh

# 版本
目前分为社区版本（Community）、devloper版本（社区plus）、企业版本以及数据中心版本

# 在docker中使用

- 需要的镜像：
```
docker pull postgres
docker pull sonarsource/sonar-scanner-cli
docker pull sonarqube:9.9.8-community
```

- 创建pgsql数据库

具体见脚本run_sonarqube.sh，将pgsql的存储持久化到物理机

- 创建sonarqube服务

具体见脚本run_sonarqube.sh，将相关数据持久化到pgsql中，也可以使用其他数据库如mysql等，本文只使用pgsql，在测试阶段也可以使用内置的数据库，但注意内嵌数据库的数据无法被迁移。

- 实战（接入到本地项目）

这里以一个github项目为例https://github.com/istio/istio

该项目主要使用go语言开发，还有一些脚本语言，像这种开源项目我们如果是开发者，可以直接将sonarqube接入到CI/CD中，如果仅仅是想检查代码而又只有拉取权限，可以同步到本地进行检测。
执行crontab_sync.sh脚本即可。其他项目修改项目地址即可


