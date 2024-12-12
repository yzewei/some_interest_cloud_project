
# 静态代码检查工具 SonarQube

## 工具介绍
SonarQube 是卓越的开源代码质量管理平台。它通过对多种编程语言的深度扫描，精准探测代码漏洞、代码异味、重复代码以及安全热点等。  
其丰富的插件生态系统可拓展功能，支持与各类开发工具集成，在持续集成/持续交付（CI/CD）流程中无缝嵌入。  
SonarQube 为开发团队提供详尽报告与可视化界面，助力团队依据数据驱动决策，高效优化代码质量，推动项目稳健前行。  

## 从编译开始
- **使用语言分析**：Java  
- **编译工具**：Gradle  
- **编译命令**：  
  ```bash
  bash build.sh
  ```

## 版本分类
SonarQube 提供以下版本以满足不同需求：  
- **社区版本（Community）**  
- **开发者版本（Developer Plus）**  
- **企业版本（Enterprise）**  
- **数据中心版本（Data Center）**

## 在 Docker 中使用

### 需要的镜像
以下镜像是运行 SonarQube 所需的关键组件：  
```bash
docker pull postgres
docker pull sonarsource/sonar-scanner-cli
docker pull sonarqube:9.9.8-community
```

### 创建 PostgreSQL 数据库
请参考脚本 `run_sonarqube.sh`，将 PostgreSQL 的存储持久化到物理机中。  

### 创建 SonarQube 服务
参考脚本 `run_sonarqube.sh`，将相关数据持久化到 PostgreSQL 中。  
> **注意**：  
> - SonarQube 支持其他数据库（如 MySQL）。  
> - 在测试阶段也可使用内置数据库，但内置数据库的数据无法迁移。  

## 实战：接入到本地项目

以下以 GitHub 项目 [istio/istio](https://github.com/istio/istio) 为例：  
- 项目主要使用 Go 语言开发，部分代码涉及脚本语言。  
- 如果你是开发者，可将 SonarQube 接入到 CI/CD 流程中。  
- 若仅想检查代码且只有拉取权限，可将项目同步到本地进行检测。  

执行 `crontab_sync.sh` 脚本即可完成同步，其他项目需修改项目地址。  

### 配置流程

1. **点击新建项目**  
   ![新建项目](https://github.com/user-attachments/assets/9d88856e-6290-4fe6-a8dc-78f5db8a7306)  

2. **选择手动配置**  
   ![手动配置](https://github.com/user-attachments/assets/db7e0d3c-aee4-4ab5-93c0-ac3754d1cdea)  

3. **配置项目名称**  
   ![配置项目名称](https://github.com/user-attachments/assets/f93551d5-452d-4ff7-8535-6224971428d8)  

4. **获取令牌**  
   ![获取令牌](https://github.com/user-attachments/assets/b7d3f9d6-5481-43cc-bf40-0dd8a308df01)  

5. **选择项目信息及适用平台**  
   ![选择平台](https://github.com/user-attachments/assets/30afb7c7-e039-433f-a579-b34db028c9bf)  

6. 修改脚本 `run_sonar-scanner-cli.sh`：  
   - 更新项目名称、SonarQube 的 URL、检查的项目路径和令牌信息。  
   - 执行脚本后，刷新 Web 页面即可查看检查结果。  

   ![检查结果](https://github.com/user-attachments/assets/3306e450-5ef8-41bb-b0ae-81b1a9ccc15d)  

## 备注
- 如果需要中文界面，请在 `Settings` -> `Marketplace` 搜索 `chinese`，安装后重启服务即可。


### 优化内容说明：
1. **标题层级调整**：使用 `#` 和 `##` 区分章节，清晰组织内容结构。
2. **段落分割**：通过空行和缩进优化段落，使内容更易读。
3. **列表排版**：将项目或步骤转为有序或无序列表。
4. **图片说明**：每张图片前增加说明，便于理解。
