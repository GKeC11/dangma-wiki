param(
  [Parameter(Mandatory = $true)]
  [string]$GuidePath,
  [Parameter(Mandatory = $true)]
  [string]$UnitGuidePath
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$docs = Join-Path $root 'docs'
$gameRoot = 'games/total-war-warhammer-3'

function Get-Sections([string]$text, [string]$pattern) {
  $result = [ordered]@{}
  $matches = [regex]::Matches($text, $pattern)
  foreach ($match in $matches) {
    $title = $match.Groups['title'].Value.Trim()
    $result[$title] = $match.Groups['body'].Value.Trim()
  }
  return $result
}

function Write-Utf8([string]$relativePath, [string]$content) {
  $path = Join-Path $docs $relativePath
  $parent = Split-Path -Parent $path
  if (-not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }
  [System.IO.File]::WriteAllText($path, ($content.Trim() + "`n"), [System.Text.UTF8Encoding]::new($false))
}

function Promote-StandaloneHeadings([string]$content) {
  return [regex]::Replace($content, '(?m)^### ', '## ')
}

$guide = Get-Content -LiteralPath $GuidePath -Raw -Encoding UTF8
$guideSections = Get-Sections $guide '(?ms)^## (?<title>[一二三四五六七八九十]+、[^\r\n]+)\r?\n(?<body>.*?)(?=^## [一二三四五六七八九十]+、|\z)'

$development = @"
# 发展、经济与招募

> 适用版本：8.1 原版。

## 发展与招募成本

$($guideSections['二、发展与招募成本'])

## 军事建筑是否需要重复建造

$($guideSections['五、一个城造了练兵营，其他城还需要造吗'])
"@
Write-Utf8 "$gameRoot/basics/development.md" $development

$miaoYing = @"
# 妙影流派

> 本页把妙影的开局发展、建筑规划、军队编制、技能加点和最终执行清单集中在一起。

## 开局发展方向

$($guideSections['三、妙影开局：先发展经济还是军事'])

## 建筑顺序

$($guideSections['四、妙影开局具体建筑顺序'])

## 开局配兵

$($guideSections['六、妙影开局具体配兵'])

## 技能加点

$($guideSections['七、妙影技能怎么点'])

## 最终推荐清单

$($guideSections['十一、妙影开局最终推荐清单'])
"@
Write-Utf8 "$gameRoot/cathay/characters/miao-ying.md" $miaoYing

Write-Utf8 "$gameRoot/cathay/characters/astromancer.md" ("# 司天丞`n`n" + (Promote-StandaloneHeadings $guideSections['八、英雄该怎么点：司天丞']))
Write-Utf8 "$gameRoot/cathay/characters/generic-lords.md" ("# 震旦普通领主对比`n`n" + (Promote-StandaloneHeadings $guideSections['九、震旦四类普通领主有什么区别']))
Write-Utf8 "$gameRoot/cathay/campaign/great-bastion.md" ("# 长垣关隘建设`n`n" + (Promote-StandaloneHeadings $guideSections['十、长垣关隘城市建设']))

$unitGuide = Get-Content -LiteralPath $UnitGuidePath -Raw -Encoding UTF8
$unitSections = Get-Sections $unitGuide '(?ms)^## (?<title>\d+\.[^\r\n]+)\r?\n(?<body>.*?)(?=^## \d+\.|\z)'

function Select-UnitSections([int[]]$numbers) {
  $parts = foreach ($entry in $unitSections.GetEnumerator()) {
    $number = [int]([regex]::Match($entry.Key, '^\d+').Value)
    if ($numbers -contains $number) {
      "## $($entry.Key)`n`n$($entry.Value)"
    }
  }
  return ($parts -join "`n`n")
}

$unitOverview = @"
# 震旦兵表：特点与快速结论

> 适用范围：原版游戏 8.1，战役模式，不启用 SFO、Radious 或单位数值 Mod。

$(Select-UnitSections @(1, 2, 3))

## 继续阅读

- [按防御、进攻、反大、远程、机动和辅助查看完整排名](./rankings)
- [查看所有单位的主职与错误用法](./roles)
- [查看前中后期20单位编制](../army/compositions)
"@
Write-Utf8 "$gameRoot/cathay/units/index.md" $unitOverview
Write-Utf8 "$gameRoot/cathay/units/rankings.md" ("# 震旦单位多维能力排名`n`n> 排名综合基础数值、兵种机制、战役成本与操作要求，不是单挑榜。`n`n" + (Select-UnitSections @(4, 5, 6, 7, 8, 9, 10)))
Write-Utf8 "$gameRoot/cathay/units/roles.md" ("# 震旦单位角色速查`n`n" + (Select-UnitSections @(11)))
Write-Utf8 "$gameRoot/cathay/army/compositions.md" ("# 军队编制与阵型操作`n`n" + (Select-UnitSections @(12, 13)))
Write-Utf8 "$gameRoot/cathay/units/faq.md" ("# 单位常见问题与资料来源`n`n" + (Select-UnitSections @(14, 15)))

Write-Host "Wiki content generated in $docs"
