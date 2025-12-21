遵循 R Packages: The Whole Game 最佳实践开发 API 封装类 R 包。

> English version: [add-api-endpoint](./add-api-endpoint.md)

## 前置条件

- 明确的需求或 API 文档 URL
- 确定的目标模块文件
- 必要的 Token 环境变量名(可选)

## 执行注意事项

1. **严格顺序**: 步骤 3 (手动验证) 必须在步骤 4 (单元测试) 之前完成
2. **等待确认**: 所有 Rterm 交互必须等待 `>` 提示符后再继续
3. **参数复用**: 优先参考同文件中已有端点的参数模式和 API 文档示例
4. **一次一项**: 每次只实现一个 API 端点

## 步骤 1: API 分析

### 文档获取策略

1. 首先尝试读取 API 文档 URL
2. 如果返回内容不包含 API 详细信息，使用浏览器浏览文档
3. 滚动浏览到页面底部，提取完整的 API 规格信息

### 提取清单

- 请求方式 (GET/POST)
- 必选参数列表（名称、类型、格式要求）
- 可选参数列表（名称、类型、默认值）
- 响应数据结构（所有字段及其含义）
- API 文档示例参数

## 步骤 2: 模式分析与实现

### 版本号决策

- **Major**: 不兼容的 API 更改
- **Minor**: 新增功能（本工作流的典型场景）
- **Patch**: Bug 修复

### 代码实现

1. 阅读目标文件，识别现有代码模式
2. 在目标文件中编写新函数：
   - 严格模仿现有封装逻辑
   - 严格按照 API 文档定义参数
   - 编写 roxygen2 文档注释，使用 `@inheritParams` 等提高文档复用
3. 更新 DESCRIPTION 版本号
4. 在 `data-raw/` 添加测试数据生成代码
5. 在 `tests/testthat/` 添加单元测试代码

## 步骤 3: 手动验证与数据生成

通过真实 API 调用生成测试固件(fixture)。

### 参数准备策略

1. 优先使用 API 文档中的示例参数
2. 时间范围参数：参考文档示例或选择合理的历史区间
3. 避免盲目猜测，先查看 API 文档

### 执行流程

```r
# 1. 启动 Rterm
Rterm --no-save --no-restore

# 2. 加载包
devtools::load_all()

# 3. 创建临时文件执行 API 调用（避免执行整个 data-raw 文件）
source("temp-api-call.R", echo = TRUE)

# 4. 验证 fixture 生成在 ./tests/testthat/fixtures/

# 5. 退出并清理
q("no")
```

清理临时文件：`rm temp-api-call.R` (Linux/Mac) 或 `del temp-api-call.R` (Windows)

## 步骤 4: 单元测试

1. 确认步骤 3 已生成固件文件
2. 在 `tests/testthat/` 添加 `test_that` 块
3. 读取固件数据，断言返回值结构（类、类型、维度）
4. 运行 `devtools::test()`
5. 如果测试失败，返回步骤 3 调整参数重新生成固件

## 步骤 5: 文档生成

```r
devtools::document()
```

更新函数帮助文档和 NAMESPACE。

## 步骤 6: 最终检查

```r
devtools::check()
```

确保 0 errors, 0 warnings, 0 notes。

## 常见问题

### API 调用返回错误

1. 检查环境变量(token)是否正确
2. 验证参数格式
3. 尝试更换测试参数
4. 查看 API 文档确认端点 URL

### 测试失败

1. 检查固件文件是否成功生成且非空
2. 手动验证固件数据格式
3. 对比同类端点的测试模式

### devtools::check() 报错

1. 先运行 `devtools::document()`
2. 检查 roxygen2 注释格式
3. 确认 NAMESPACE 导出项一致
4. 查看具体错误信息，针对性解决

### Rterm 交互异常

1. 如果命令无响应，可能是上一步未完成，等待更长时间
2. 如果提示找不到函数，确认 `devtools::load_all()` 已成功执行
3. 如果会话卡死，终止进程并重新启动 Rterm
