# 操作記述

## リレーショナル代数

### 和両立

リレーション$R(A_1, A_2, \ldots, A_n)$とリレーション$S(B_1, B_2, \ldots, B_m)$が和両立（union compatible）とは，次の二つの条件を満たすことである．

- $n = m$．
- $\text{dom}(A_i) = \text{dom}(B_i)$であり，$1 \leq i \leq n$．

:::{admonition} Example

ある大学の学生データベースには，2024年度入学生のデータを格納するリレーション`Student_2024`と，2025年度入学生のデータを格納するリレーション`Student_2025`がある．

**Student_2024**
| ID     | Name  | major            |
| ------ | ----- | ---------------- |
| 202401 | Alice | Mathematics      |
| 202402 | Bob   | Computer Science |
| 202403 | Carol | Physics          |
| ...    | ...   | ...              |

**Student_2025**
| ID     | Name  | major       |
| ------ | ----- | ----------- |
| 202501 | David | Mathematics |
| 202502 | Eve   | Physics     |
| 202503 | Frank | Chemistry   |
| ...    | ...   | ...         |

`Student_2024`と`Student_2025`の次数は共に3であり，それぞれの属性（ID, Name, major）の定義域は共通であるため，これらは和両立である．

:::