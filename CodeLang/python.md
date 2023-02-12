# python

- 虚拟环境

```bash
# 创建虚拟环境
python3 -m venv ~/PyVenv/test_env

# 进入虚拟环境
source ~/PyVenv/test_env/bin/activate

# 退出虚拟环境
deactivate
```

- 后台运行

```bash
# 日志默认可以实时写入
nohup python3 main.py >> nohup.out &

# print的实时写入
nohup python3 -u main.py >> nohup.out &
```

- 依赖文件

```bash
# 生成依赖文件
pipreqs ./
# 强制覆盖生成新的依赖文件
pipreqs --force ./

# 安装依赖文件
pip3 install -r ./requirements.txt \
    --index-url https://mirrors.cloud.tencent.com/pypi/simple/ \
    --extra-index-url https://mirrors.tencent.com/repository/pypi/tencent_pypi/simple/
```

- 文本解码

```python
# 将"\xE5\xB9\xB3\xE5\xAE..."转为中文
start_data = "\xE5\xB9\xB3\xE5\xAE\x89\xE9\x93\xB6\xE8\xA1\x8C\xE8\x82\xA1\xE4\xBB\xBD\xE6\x9C\x89\xE9\x99\x90\xE5\x85\xAC\xE5\x8F\xB8\xE6\xB7\xB1\xE5\x9C\xB3\xE5\x88\x86\xE8\xA1\x8C"
first_data = start_data.encode("raw_unicode_escape")
last_data = first_data.decode()
print(last_data)
# 平安银行股份有限公司深圳分行
```

- Json 字典 字符串

```python
# Json 字典
import json
info_map = {"a": 1, "b": "hello"}
info_map_str = json.dumps(info_map)
print(type(info_map_str))
info_map = json.loads(info_map_str)
print(type(info_map))

# 字典 字符串
import ast
one_dict = {"a": 1, "b": "hello"}
one_str = str(one_dict)
demo_dict = ast.literal_eval(one_str)
demo_dict == one_dict
```
