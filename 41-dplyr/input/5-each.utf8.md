---
title: "Introduction to `dplyr`"
---






# Introduction

The `dplyr` package for `R` is very powerful for data management since:

* it simplifies how you can think about common data manipulation tasks;
* it provides simple “verbs”, functions that correspond to the most common data manipulation tasks;
* it uses efficient data storage backends, so you spend less time waiting for the computer.

Let's start by having a look at how data frames are saved and visualized and at the main verb functions of `dplyr`.


# `tbl_df`: the `dplyr` Data Frame Class

`dplyr` can work with data frames as is but it is worthwhile to convert them to a `tbl_df`: this is a wrapper around a data frame that will not accidentally print a lot of data to the screen, indeed tbl objects only print a few rows and all the columns that fit on one screen, describing the rest of it as text.


```r
data(bank)
class(bank)
```

```
## [1] "data.frame"
```

```r
bank
```

```
##          id age           job  marital education default balance housing loan   contact day month year
## 1         1  58    management  married  tertiary      no    2143     yes   no   unknown   5   may 2008
## 2         2  44    technician   single secondary      no      29     yes   no   unknown   5   may 2008
## 3         3  33  entrepreneur  married secondary      no       2     yes  yes   unknown   5   may 2008
## 4         4  47   blue-collar  married   unknown      no    1506     yes   no   unknown   5   may 2008
## 5         5  33       unknown   single   unknown      no       1      no   no   unknown   5   may 2008
## 6         6  35    management  married  tertiary      no     231     yes   no   unknown   5   may 2008
## 7         7  28    management   single  tertiary      no     447     yes  yes   unknown   5   may 2008
## 8         8  42  entrepreneur divorced  tertiary     yes       2     yes   no   unknown   5   may 2008
## 9         9  58       retired  married   primary      no     121     yes   no   unknown   5   may 2008
## 10       10  43    technician   single secondary      no     593     yes   no   unknown   5   may 2008
## 11       11  41        admin. divorced secondary      no     270     yes   no   unknown   5   may 2008
## 12       12  29        admin.   single secondary      no     390     yes   no   unknown   5   may 2008
## 13       13  53    technician  married secondary      no       6     yes   no   unknown   5   may 2008
## 14       14  58    technician  married   unknown      no      71     yes   no   unknown   5   may 2008
## 15       15  57      services  married secondary      no     162     yes   no   unknown   5   may 2008
## 16       16  51       retired  married   primary      no     229     yes   no   unknown   5   may 2008
## 17       17  45        admin.   single   unknown      no      13     yes   no   unknown   5   may 2008
## 18       18  57   blue-collar  married   primary      no      52     yes   no   unknown   5   may 2008
## 19       19  60       retired  married   primary      no      60     yes   no   unknown   5   may 2008
## 20       20  33      services  married secondary      no       0     yes   no   unknown   5   may 2008
## 21       21  28   blue-collar  married secondary      no     723     yes  yes   unknown   5   may 2008
## 22       22  56    management  married  tertiary      no     779     yes   no   unknown   5   may 2008
## 23       23  32   blue-collar   single   primary      no      23     yes  yes   unknown   5   may 2008
## 24       24  25      services  married secondary      no      50     yes   no   unknown   5   may 2008
## 25       25  40       retired  married   primary      no       0     yes  yes   unknown   5   may 2008
## 26       26  44        admin.  married secondary      no    -372     yes   no   unknown   5   may 2008
## 27       27  39    management   single  tertiary      no     255     yes   no   unknown   5   may 2008
## 28       28  52  entrepreneur  married secondary      no     113     yes  yes   unknown   5   may 2008
## 29       29  46    management   single secondary      no    -246     yes   no   unknown   5   may 2008
## 30       30  36    technician   single secondary      no     265     yes  yes   unknown   5   may 2008
## 31       31  57    technician  married secondary      no     839      no  yes   unknown   5   may 2008
## 32       32  49    management  married  tertiary      no     378     yes   no   unknown   5   may 2008
## 33       33  60        admin.  married secondary      no      39     yes  yes   unknown   5   may 2008
## 34       34  59   blue-collar  married secondary      no       0     yes   no   unknown   5   may 2008
## 35       35  51    management  married  tertiary      no   10635     yes   no   unknown   5   may 2008
## 36       36  57    technician divorced secondary      no      63     yes   no   unknown   5   may 2008
## 37       37  25   blue-collar  married secondary      no      -7     yes   no   unknown   5   may 2008
## 38       38  53    technician  married secondary      no      -3      no   no   unknown   5   may 2008
## 39       39  36        admin. divorced secondary      no     506     yes   no   unknown   5   may 2008
## 40       40  37        admin.   single secondary      no       0     yes   no   unknown   5   may 2008
## 41       41  44      services divorced secondary      no    2586     yes   no   unknown   5   may 2008
## 42       42  50    management  married secondary      no      49     yes   no   unknown   5   may 2008
## 43       43  60   blue-collar  married   unknown      no     104     yes   no   unknown   5   may 2008
## 44       44  54       retired  married secondary      no     529     yes   no   unknown   5   may 2008
## 45       45  58       retired  married   unknown      no      96     yes   no   unknown   5   may 2008
## 46       46  36        admin.   single   primary      no    -171     yes   no   unknown   5   may 2008
## 47       47  58 self-employed  married  tertiary      no    -364     yes   no   unknown   5   may 2008
## 48       48  44    technician  married secondary      no       0     yes   no   unknown   5   may 2008
## 49       49  55    technician divorced secondary      no       0      no   no   unknown   5   may 2008
## 50       50  29    management   single  tertiary      no       0     yes   no   unknown   5   may 2008
## 51       51  54   blue-collar  married secondary      no    1291     yes   no   unknown   5   may 2008
## 52       52  48    management divorced  tertiary      no    -244     yes   no   unknown   5   may 2008
## 53       53  32    management  married  tertiary      no       0     yes   no   unknown   5   may 2008
## 54       54  42        admin.   single secondary      no     -76     yes   no   unknown   5   may 2008
## 55       55  24    technician   single secondary      no    -103     yes  yes   unknown   5   may 2008
## 56       56  38  entrepreneur   single  tertiary      no     243      no  yes   unknown   5   may 2008
## 57       57  38    management   single  tertiary      no     424     yes   no   unknown   5   may 2008
## 58       58  47   blue-collar  married   unknown      no     306     yes   no   unknown   5   may 2008
## 59       59  40   blue-collar   single   unknown      no      24     yes   no   unknown   5   may 2008
## 60       60  46      services  married   primary      no     179     yes   no   unknown   5   may 2008
## 61       61  32        admin.  married  tertiary      no       0     yes   no   unknown   5   may 2008
## 62       62  53    technician divorced secondary      no     989     yes   no   unknown   5   may 2008
## 63       63  57   blue-collar  married   primary      no     249     yes   no   unknown   5   may 2008
## 64       64  33      services  married secondary      no     790     yes   no   unknown   5   may 2008
## 65       65  49   blue-collar  married   unknown      no     154     yes   no   unknown   5   may 2008
## 66       66  51    management  married  tertiary      no    6530     yes   no   unknown   5   may 2008
## 67       67  60       retired  married  tertiary      no     100      no   no   unknown   5   may 2008
## 68       68  59    management divorced  tertiary      no      59     yes   no   unknown   5   may 2008
## 69       69  55    technician  married secondary      no    1205     yes   no   unknown   5   may 2008
## 70       70  35   blue-collar   single secondary      no   12223     yes  yes   unknown   5   may 2008
## 71       71  57   blue-collar  married secondary      no    5935     yes  yes   unknown   5   may 2008
## 72       72  31      services  married secondary      no      25     yes  yes   unknown   5   may 2008
## 73       73  54    management  married secondary      no     282     yes  yes   unknown   5   may 2008
## 74       74  55   blue-collar  married   primary      no      23     yes   no   unknown   5   may 2008
## 75       75  43    technician  married secondary      no    1937     yes   no   unknown   5   may 2008
## 76       76  53    technician  married secondary      no     384     yes   no   unknown   5   may 2008
## 77       77  44   blue-collar  married secondary      no     582      no  yes   unknown   5   may 2008
## 78       78  55      services divorced secondary      no      91      no   no   unknown   5   may 2008
## 79       79  49      services divorced secondary      no       0     yes  yes   unknown   5   may 2008
## 80       80  55      services divorced secondary     yes       1     yes   no   unknown   5   may 2008
## 81       81  45        admin.   single secondary      no     206     yes   no   unknown   5   may 2008
## 82       82  47      services divorced secondary      no     164      no   no   unknown   5   may 2008
## 83       83  42    technician   single secondary      no     690     yes   no   unknown   5   may 2008
## 84       84  59        admin.  married secondary      no    2343     yes   no   unknown   5   may 2008
## 85       85  46 self-employed  married  tertiary      no     137     yes  yes   unknown   5   may 2008
## 86       86  51   blue-collar  married   primary      no     173     yes   no   unknown   5   may 2008
## 87       87  56        admin.  married secondary      no      45      no   no   unknown   5   may 2008
## 88       88  41    technician  married secondary      no    1270     yes   no   unknown   5   may 2008
## 89       89  46    management divorced secondary      no      16     yes  yes   unknown   5   may 2008
## 90       90  57       retired  married secondary      no     486     yes   no   unknown   5   may 2008
## 91       91  42    management   single secondary      no      50      no   no   unknown   5   may 2008
## 92       92  30    technician  married secondary      no     152     yes  yes   unknown   5   may 2008
## 93       93  60        admin.  married secondary      no     290     yes   no   unknown   5   may 2008
## 94       94  60   blue-collar  married   unknown      no      54     yes   no   unknown   5   may 2008
## 95       95  57  entrepreneur divorced secondary      no     -37      no   no   unknown   5   may 2008
## 96       96  36    management  married  tertiary      no     101     yes  yes   unknown   5   may 2008
## 97       97  55   blue-collar  married secondary      no     383      no   no   unknown   5   may 2008
## 98       98  60       retired  married  tertiary      no      81     yes   no   unknown   5   may 2008
## 99       99  39    technician  married secondary      no       0     yes   no   unknown   5   may 2008
## 100     100  46    management  married  tertiary      no     229     yes   no   unknown   5   may 2008
## 101     101  44   blue-collar  married secondary      no    -674     yes   no   unknown   5   may 2008
## 102     102  53   blue-collar  married   primary      no      90      no   no   unknown   5   may 2008
## 103     103  52   blue-collar  married   primary      no     128     yes   no   unknown   5   may 2008
## 104     104  59   blue-collar  married   primary      no     179     yes   no   unknown   5   may 2008
## 105     105  27    technician   single  tertiary      no       0     yes   no   unknown   5   may 2008
## 106     106  44   blue-collar  married secondary      no      54     yes   no   unknown   5   may 2008
## 107     107  47    technician  married  tertiary      no     151     yes   no   unknown   5   may 2008
## 108     108  34        admin.  married secondary      no      61      no  yes   unknown   5   may 2008
## 109     109  59       retired   single secondary      no      30     yes   no   unknown   5   may 2008
## 110     110  45    management  married  tertiary      no     523     yes   no   unknown   5   may 2008
## 111     111  29      services divorced secondary      no      31     yes   no   unknown   5   may 2008
## 112     112  46    technician divorced secondary      no      79      no   no   unknown   5   may 2008
## 113     113  56 self-employed  married   primary      no     -34     yes  yes   unknown   5   may 2008
## 114     114  36   blue-collar  married   primary      no     448     yes   no   unknown   5   may 2008
## 115     115  59       retired divorced   primary      no      81     yes   no   unknown   5   may 2008
## 116     116  44   blue-collar  married secondary      no     144     yes   no   unknown   5   may 2008
## 117     117  41        admin.  married secondary      no     351     yes   no   unknown   5   may 2008
## 118     118  33    management   single  tertiary      no     -67     yes   no   unknown   5   may 2008
## 119     119  59    management divorced  tertiary      no     262      no   no   unknown   5   may 2008
## 120     120  57    technician  married   primary      no       0      no   no   unknown   5   may 2008
## 121     121  56    technician divorced   unknown      no      56     yes   no   unknown   5   may 2008
## 122     122  51   blue-collar  married secondary      no      26     yes   no   unknown   5   may 2008
## 123     123  34        admin.  married   unknown      no       3     yes   no   unknown   5   may 2008
## 124     124  43      services  married secondary      no      41     yes  yes   unknown   5   may 2008
## 125     125  52    technician  married  tertiary      no       7      no  yes   unknown   5   may 2008
## 126     126  33    technician   single secondary      no     105     yes   no   unknown   5   may 2008
## 127     127  29        admin.   single secondary      no     818     yes  yes   unknown   5   may 2008
## 128     128  34      services  married secondary      no     -16     yes  yes   unknown   5   may 2008
## 129     129  31   blue-collar  married secondary      no       0     yes   no   unknown   5   may 2008
## 130     130  55      services  married secondary      no    2476     yes   no   unknown   5   may 2008
## 131     131  55    management  married   unknown      no    1185      no   no   unknown   5   may 2008
## 132     132  32        admin.   single secondary      no     217     yes   no   unknown   5   may 2008
## 133     133  38    technician   single secondary      no    1685     yes   no   unknown   5   may 2008
## 134     134  55        admin.   single secondary      no     802     yes  yes   unknown   5   may 2008
## 135     135  28    unemployed   single  tertiary      no       0     yes   no   unknown   5   may 2008
## 136     136  23   blue-collar  married secondary      no      94     yes   no   unknown   5   may 2008
## 137     137  32    technician   single secondary      no       0     yes   no   unknown   5   may 2008
## 138     138  43      services   single   unknown      no       0      no   no   unknown   5   may 2008
## 139     139  32   blue-collar  married secondary      no     517     yes   no   unknown   5   may 2008
## 140     140  46   blue-collar  married secondary      no     265     yes   no   unknown   5   may 2008
## 141     141  53     housemaid divorced   primary      no     947     yes   no   unknown   5   may 2008
## 142     142  34 self-employed   single secondary      no       3     yes   no   unknown   5   may 2008
## 143     143  57    unemployed  married  tertiary      no      42      no   no   unknown   5   may 2008
## 144     144  37   blue-collar  married secondary      no      37     yes   no   unknown   5   may 2008
## 145     145  59   blue-collar  married secondary      no      57     yes   no   unknown   5   may 2008
## 146     146  33      services  married secondary      no      22     yes   no   unknown   5   may 2008
## 147     147  56   blue-collar divorced   primary      no       8     yes   no   unknown   5   may 2008
## 148     148  48    unemployed  married secondary      no     293     yes   no   unknown   5   may 2008
## 149     149  43      services  married   primary      no       3     yes   no   unknown   5   may 2008
## 150     150  54   blue-collar  married   primary      no     348     yes   no   unknown   5   may 2008
## 151     151  51   blue-collar  married   unknown      no     -19     yes   no   unknown   5   may 2008
## 152     152  26       student   single secondary      no       0     yes   no   unknown   5   may 2008
## 153     153  40    management  married  tertiary      no      -4     yes   no   unknown   5   may 2008
## 154     154  39    management  married secondary      no      18     yes   no   unknown   5   may 2008
## 155     155  50    technician  married   primary      no     139      no   no   unknown   5   may 2008
## 156     156  41      services  married secondary      no       0     yes   no   unknown   5   may 2008
## 157     157  51   blue-collar  married   unknown      no    1883     yes   no   unknown   5   may 2008
## 158     158  60       retired divorced secondary      no     216     yes   no   unknown   5   may 2008
## 159     159  52   blue-collar  married secondary      no     782     yes   no   unknown   5   may 2008
## 160     160  48   blue-collar  married secondary      no     904     yes   no   unknown   5   may 2008
## 161     161  48      services  married   unknown      no    1705     yes   no   unknown   5   may 2008
## 162     162  39    technician   single  tertiary      no      47     yes   no   unknown   5   may 2008
## 163     163  47      services   single secondary      no     176     yes   no   unknown   5   may 2008
## 164     164  40   blue-collar  married secondary      no    1225     yes   no   unknown   5   may 2008
## 165     165  45    technician  married secondary      no      86     yes   no   unknown   5   may 2008
## 166     166  26        admin.   single secondary      no      82     yes   no   unknown   5   may 2008
## 167     167  52    management  married  tertiary      no     271     yes   no   unknown   5   may 2008
## 168     168  54    technician  married secondary      no    1378     yes   no   unknown   5   may 2008
## 169     169  54        admin.  married  tertiary      no     184      no   no   unknown   5   may 2008
## 170     170  50   blue-collar  married   primary      no       0      no   no   unknown   5   may 2008
## 171     171  35   blue-collar  married secondary      no       0     yes   no   unknown   5   may 2008
## 172     172  44      services  married secondary      no    1357     yes  yes   unknown   5   may 2008
## 173     173  53  entrepreneur  married   unknown      no      19     yes   no   unknown   5   may 2008
## 174     174  35       retired   single   primary      no     434      no   no   unknown   5   may 2008
## 175     175  60        admin. divorced secondary      no      92     yes   no   unknown   5   may 2008
## 176     176  53        admin. divorced secondary      no    1151     yes   no   unknown   5   may 2008
## 177     177  48    unemployed  married secondary      no      41     yes   no   unknown   5   may 2008
## 178     178  34    technician  married secondary      no      51     yes   no   unknown   5   may 2008
## 179     179  54      services  married secondary      no     214     yes   no   unknown   5   may 2008
## 180     180  51    management  married secondary      no    1161     yes   no   unknown   5   may 2008
## 181     181  31      services  married  tertiary      no      37     yes   no   unknown   5   may 2008
## 182     182  35    technician divorced secondary      no     787     yes   no   unknown   5   may 2008
## 183     183  35      services  married secondary      no      59     yes   no   unknown   5   may 2008
## 184     184  38    technician  married secondary      no     253     yes   no   unknown   5   may 2008
## 185     185  36        admin.  married  tertiary      no     211     yes   no   unknown   5   may 2008
## 186     186  58       retired  married   primary      no     235     yes   no   unknown   5   may 2008
## 187     187  40      services divorced   unknown      no    4384     yes   no   unknown   5   may 2008
## 188     188  54    management  married secondary      no    4080      no   no   unknown   5   may 2008
## 189     189  34   blue-collar   single secondary      no      53     yes  yes   unknown   5   may 2008
## 190     190  31    management   single  tertiary      no       0     yes   no   unknown   5   may 2008
## 191     191  51       retired  married secondary      no    2127     yes   no   unknown   5   may 2008
## 192     192  33    management  married  tertiary      no     377     yes   no   unknown   5   may 2008
## 193     193  55    management  married  tertiary      no      73     yes   no   unknown   5   may 2008
## 194     194  42        admin.  married secondary      no     445     yes   no   unknown   5   may 2008
## 195     195  34   blue-collar  married secondary      no     243     yes   no   unknown   5   may 2008
## 196     196  33   blue-collar   single secondary      no     307     yes   no   unknown   5   may 2008
## 197     197  38      services  married secondary      no     155     yes   no   unknown   5   may 2008
## 198     198  50    technician divorced  tertiary      no     173      no  yes   unknown   5   may 2008
## 199     199  43    management  married  tertiary      no     400     yes   no   unknown   5   may 2008
## 200     200  61   blue-collar divorced   primary      no    1428     yes   no   unknown   5   may 2008
## 201     201  47        admin.  married secondary      no     219     yes   no   unknown   5   may 2008
## 202     202  48 self-employed  married  tertiary      no       7     yes   no   unknown   5   may 2008
## 203     203  44   blue-collar  married secondary      no     575     yes   no   unknown   5   may 2008
## 204     204  35       student   single   unknown      no     298     yes   no   unknown   5   may 2008
## 205     205  35      services  married secondary      no       0     yes   no   unknown   5   may 2008
## 206     206  50      services  married secondary      no    5699     yes   no   unknown   5   may 2008
## 207     207  41    management  married  tertiary      no     176     yes  yes   unknown   5   may 2008
## 208     208  41    management  married  tertiary      no     517     yes   no   unknown   5   may 2008
## 209     209  39      services   single   unknown      no     257     yes   no   unknown   5   may 2008
## 210     210  42       retired  married secondary      no      56     yes   no   unknown   5   may 2008
## 211     211  38   blue-collar  married secondary      no    -390     yes   no   unknown   5   may 2008
## 212     212  53       retired  married secondary      no     330     yes   no   unknown   5   may 2008
## 213     213  59     housemaid divorced   primary      no     195      no   no   unknown   5   may 2008
## 214     214  36      services  married secondary      no     301     yes   no   unknown   5   may 2008
## 215     215  54   blue-collar  married   primary      no     -41     yes   no   unknown   5   may 2008
## 216     216  40    technician  married  tertiary      no     483     yes   no   unknown   5   may 2008
## 217     217  47       unknown  married   unknown      no      28      no   no   unknown   5   may 2008
## 218     218  53    unemployed  married   unknown      no      13      no   no   unknown   5   may 2008
## 219     219  46     housemaid  married   primary      no     965      no   no   unknown   5   may 2008
## 220     220  39    management  married  tertiary      no     378     yes  yes   unknown   5   may 2008
## 221     221  40    unemployed  married secondary      no     219     yes   no   unknown   5   may 2008
## 222     222  28   blue-collar  married   primary      no     324     yes   no   unknown   5   may 2008
## 223     223  35  entrepreneur divorced secondary      no     -69     yes   no   unknown   5   may 2008
## 224     224  55       retired  married secondary      no       0      no  yes   unknown   5   may 2008
## 225     225  43    technician divorced   unknown      no     205     yes   no   unknown   5   may 2008
## 226     226  48   blue-collar  married   primary      no     278     yes   no   unknown   5   may 2008
## 227     227  58    management  married   unknown      no    1065     yes   no   unknown   5   may 2008
## 228     228  33    management   single  tertiary      no      34     yes   no   unknown   5   may 2008
## 229     229  36   blue-collar  married   unknown      no    1033      no   no   unknown   5   may 2008
## 230     230  53      services divorced secondary      no    1467     yes   no   unknown   5   may 2008
## 231     231  47   blue-collar  married   primary      no     -12     yes   no   unknown   5   may 2008
## 232     232  31      services  married secondary      no     388     yes   no   unknown   5   may 2008
## 233     233  57  entrepreneur  married secondary      no     294     yes   no   unknown   5   may 2008
## 234     234  53   blue-collar  married   unknown      no    1827      no   no   unknown   5   may 2008
## 235     235  55   blue-collar  married   primary      no     627     yes   no   unknown   5   may 2008
## 236     236  45   blue-collar  married   primary      no      25     yes   no   unknown   5   may 2008
## 237     237  53        admin. divorced secondary      no     315     yes   no   unknown   5   may 2008
## 238     238  37   blue-collar  married   primary      no       0     yes   no   unknown   5   may 2008
## 239     239  44        admin. divorced secondary      no      66     yes   no   unknown   5   may 2008
## 240     240  49   blue-collar divorced   primary      no      -9     yes  yes   unknown   5   may 2008
## 241     241  46    technician  married secondary      no     349     yes  yes   unknown   5   may 2008
## 242     242  43  entrepreneur  married   unknown      no     100     yes   no   unknown   5   may 2008
## 243     243  38        admin.  married secondary      no       0      no   no   unknown   5   may 2008
## 244     244  43    technician  married secondary      no     434     yes   no   unknown   5   may 2008
## 245     245  49    management  married  tertiary      no    3237     yes   no   unknown   5   may 2008
## 246     246  42    management  married   unknown      no     275      no   no   unknown   5   may 2008
## 247     247  22   blue-collar   single secondary      no       0     yes   no   unknown   5   may 2008
## 248     248  40    management  married  tertiary      no     207     yes   no   unknown   5   may 2008
## 249     249  39   blue-collar  married secondary      no     483     yes   no   unknown   5   may 2008
## 250     250  51      services  married secondary      no    2248     yes   no   unknown   5   may 2008
## 251     251  49        admin.  married secondary      no     428     yes   no   unknown   5   may 2008
## 252     252  53   blue-collar  married secondary      no       0     yes  yes   unknown   5   may 2008
## 253     253  34      services   single secondary      no       0     yes   no   unknown   5   may 2008
## 254     254  33    technician divorced secondary      no     140     yes   no   unknown   5   may 2008
## 255     255  50    management   single  tertiary      no     297     yes   no   unknown   5   may 2008
## 256     256  39   blue-collar  married   primary      no     279     yes   no   unknown   5   may 2008
## 257     257  59  entrepreneur divorced secondary      no     901     yes   no   unknown   5   may 2008
## 258     258  30    technician   single secondary      no    2573     yes   no   unknown   5   may 2008
## 259     259  36      services  married secondary      no     143     yes  yes   unknown   5   may 2008
## 260     260  40   blue-collar  married secondary      no     475     yes   no   unknown   5   may 2008
## 261     261  53   blue-collar  married secondary      no      70     yes   no   unknown   5   may 2008
## 262     262  34    management   single  tertiary      no     318     yes   no   unknown   5   may 2008
## 263     263  37    technician  married secondary      no     275     yes   no   unknown   5   may 2008
## 264     264  42    management divorced  tertiary      no     742     yes   no   unknown   5   may 2008
## 265     265  41  entrepreneur  married   primary      no     236     yes   no   unknown   5   may 2008
## 266     266  30       student   single  tertiary      no      25     yes   no   unknown   5   may 2008
## 267     267  37    management   single  tertiary      no     600     yes   no   unknown   5   may 2008
## 268     268  39        admin. divorced secondary      no    -349     yes   no   unknown   5   may 2008
## 269     269  41   blue-collar  married   primary      no     183     yes  yes   unknown   5   may 2008
## 270     270  40   blue-collar  married   primary      no       0     yes   no   unknown   5   may 2008
## 271     271  42    management   single  tertiary      no       0     yes  yes   unknown   5   may 2008
## 272     272  40   blue-collar divorced   primary      no       0     yes   no   unknown   5   may 2008
## 273     273  57    technician  married secondary      no    1078     yes   no   unknown   5   may 2008
## 274     274  56  entrepreneur divorced secondary      no     155      no   no   unknown   5   may 2008
## 275     275  37        admin.  married secondary      no     190     yes   no   unknown   5   may 2008
## 276     276  59       retired  married secondary      no     319     yes   no   unknown   5   may 2008
## 277     277  39      services divorced secondary      no    -185     yes   no   unknown   5   may 2008
## 278     278  49      services  married secondary      no      47      no   no   unknown   5   may 2008
## 279     279  38      services   single secondary      no     570     yes   no   unknown   5   may 2008
## 280     280  36 self-employed  married  tertiary      no      19      no   no   unknown   5   may 2008
## 281     281  50   blue-collar  married   primary      no      61     yes   no   unknown   5   may 2008
## 282     282  41        admin.  married secondary      no     -62     yes  yes   unknown   5   may 2008
## 283     283  54    technician  married  tertiary      no     258      no   no   unknown   5   may 2008
## 284     284  58   blue-collar  married   primary      no      76     yes   no   unknown   5   may 2008
## 285     285  30   blue-collar   single secondary      no       0     yes   no   unknown   5   may 2008
## 286     286  33        admin.   single secondary      no     352     yes   no   unknown   5   may 2008
## 287     287  47        admin.  married secondary      no     368     yes   no   unknown   5   may 2008
## 288     288  50    technician   single  tertiary      no     339     yes   no   unknown   5   may 2008
## 289     289  32   blue-collar  married secondary      no    1331     yes   no   unknown   5   may 2008
## 290     290  40 self-employed  married secondary      no     672     yes   no   unknown   5   may 2008
## 291     291  37    management  married  tertiary      no      58     yes   no   unknown   5   may 2008
## 292     292  54    technician   single   unknown      no     447     yes   no   unknown   5   may 2008
## 293     293  24       student   single secondary      no     423     yes   no   unknown   5   may 2008
## 294     294  54    management  married  tertiary      no       0      no   no   unknown   5   may 2008
## 295     295  34    technician  married secondary      no      19     yes   no   unknown   5   may 2008
## 296     296  56    technician divorced   primary      no      13     yes   no   unknown   5   may 2008
## 297     297  31   blue-collar   single secondary      no       3     yes   no   unknown   5   may 2008
## 298     298  24       student   single secondary      no      82     yes   no   unknown   5   may 2008
## 299     299  42   blue-collar divorced   primary      no      28     yes   no   unknown   5   may 2008
## 300     300  57    technician  married secondary      no     792     yes   no   unknown   5   may 2008
## 301     301  42   blue-collar  married   unknown      no     408     yes   no   unknown   5   may 2008
## 302     302  51        admin.  married secondary      no     531     yes   no   unknown   5   may 2008
## 303     303  57       retired  married secondary      no     211     yes   no   unknown   5   may 2008
## 304     304  36      services   single secondary      no      62     yes   no   unknown   5   may 2008
## 305     305  53      services  married   unknown      no     257     yes   no   unknown   5   may 2008
## 306     306  50    technician  married secondary      no    1234     yes   no   unknown   5   may 2008
## 307     307  54    management  married  tertiary      no     313     yes   no   unknown   5   may 2008
## 308     308  55   blue-collar  married secondary      no      89     yes   no   unknown   5   may 2008
## 309     309  44   blue-collar  married secondary      no     129     yes  yes   unknown   5   may 2008
## 310     310  43    management  married   unknown      no       0     yes   no   unknown   5   may 2008
## 311     311  56        admin.  married secondary      no     353     yes   no   unknown   5   may 2008
## 312     312  54    technician  married   unknown      no     851     yes   no   unknown   5   may 2008
## 313     313  55      services divorced   primary      no      96     yes  yes   unknown   5   may 2008
## 314     314  37      services divorced secondary      no     398     yes  yes   unknown   5   may 2008
## 315     315  33        admin.   single  tertiary      no     193      no   no   unknown   5   may 2008
## 316     316  46        admin.  married secondary      no    -358     yes   no   unknown   5   may 2008
## 317     317  36   blue-collar  married secondary      no     539     yes  yes   unknown   5   may 2008
## 318     318  51    technician   single secondary      no       0     yes   no   unknown   5   may 2008
## 319     319  40       retired   single   primary      no       0      no   no   unknown   5   may 2008
## 320     320  42   blue-collar  married secondary      no     490     yes   no   unknown   5   may 2008
## 321     321  51   blue-collar  married secondary      no       0     yes   no   unknown   5   may 2008
## 322     322  49   blue-collar  married   unknown      no     403     yes   no   unknown   5   may 2008
## 323     323  48    management  married secondary      no     161     yes   no   unknown   5   may 2008
## 324     324  32    technician divorced  tertiary      no    2558      no   no   unknown   5   may 2008
## 325     325  31        admin.   single secondary      no      98     yes   no   unknown   5   may 2008
## 326     326  55    management   single  tertiary      no     115      no   no   unknown   5   may 2008
## 327     327  40   blue-collar   single secondary      no     436     yes   no   unknown   5   may 2008
## 328     328  47    technician  married  tertiary      no     831     yes   no   unknown   5   may 2008
## 329     329  57    technician  married   unknown      no     206     yes   no   unknown   5   may 2008
## 330     330  41   blue-collar  married secondary      no     290     yes   no   unknown   5   may 2008
## 331     331  48   blue-collar  married secondary      no       1      no   no   unknown   5   may 2008
## 332     332  42   blue-collar  married   unknown      no      57     yes   no   unknown   5   may 2008
## 333     333  30   blue-collar   single secondary      no    -457     yes   no   unknown   5   may 2008
## 334     334  58    management   single  tertiary      no    1387     yes   no   unknown   5   may 2008
## 335     335  45    management divorced  tertiary      no   24598     yes   no   unknown   5   may 2008
## 336     336  49   blue-collar  married secondary      no      30     yes   no   unknown   5   may 2008
## 337     337  42        admin.   single secondary      no    1022     yes   no   unknown   5   may 2008
## 338     338  53    technician  married secondary      no      56     yes  yes   unknown   5   may 2008
## 339     339  51        admin.   single secondary     yes      -2      no   no   unknown   5   may 2008
## 340     340  32      services   single secondary      no     121     yes   no   unknown   5   may 2008
## 341     341  41   blue-collar   single secondary      no     842     yes   no   unknown   5   may 2008
## 342     342  43    management divorced secondary      no     693     yes   no   unknown   5   may 2008
## 343     343  40   blue-collar divorced secondary      no    -333     yes   no   unknown   5   may 2008
## 344     344  50   blue-collar  married   primary      no    1533     yes   no   unknown   5   may 2008
## 345     345  34    management  married  tertiary      no      46     yes   no   unknown   5   may 2008
## 346     346  53      services  married   unknown      no      18      no   no   unknown   5   may 2008
## 347     347  45    technician  married secondary      no      44     yes   no   unknown   5   may 2008
## 348     348  39   blue-collar  married   primary      no    -100     yes   no   unknown   5   may 2008
## 349     349  44      services  married  tertiary      no     510     yes   no   unknown   5   may 2008
## 350     350  55    management  married  tertiary      no     685     yes   no   unknown   5   may 2008
## 351     351  46    management   single  tertiary      no     187     yes   no   unknown   5   may 2008
## 352     352  45   blue-collar  married secondary      no      66     yes   no   unknown   5   may 2008
## 353     353  34        admin.  married secondary      no     560     yes   no   unknown   5   may 2008
## 354     354  36   blue-collar  married secondary      no       0     yes   no   unknown   5   may 2008
## 355     355  59       unknown divorced   unknown      no      27      no   no   unknown   5   may 2008
## 356     356  31        admin.   single secondary      no      12     yes   no   unknown   5   may 2008
## 357     357  44   blue-collar   single secondary      no      34     yes   no   unknown   5   may 2008
## 358     358  33  entrepreneur   single  tertiary      no    1068     yes   no   unknown   5   may 2008
## 359     359  40   blue-collar  married secondary      no     211     yes   no   unknown   5   may 2008
## 360     360  46        admin.   single  tertiary      no     377     yes   no   unknown   5   may 2008
## 361     361  48    management  married  tertiary      no     263     yes   no   unknown   5   may 2008
## 362     362  42      services  married secondary      no    1263     yes   no   unknown   6   may 2008
## 363     363  27      services  married secondary      no       8     yes   no   unknown   6   may 2008
## 364     364  48        admin.  married secondary      no     126     yes  yes   unknown   6   may 2008
## 365     365  59        admin.  married secondary      no     230     yes   no   unknown   6   may 2008
## 366     366  46    technician  married  tertiary      no     841     yes   no   unknown   6   may 2008
## 367     367  38        admin. divorced secondary      no     308     yes   no   unknown   6   may 2008
## 368     368  43    management divorced  tertiary      no       1     yes   no   unknown   6   may 2008
## 369     369  38        admin. divorced  tertiary      no      86     yes   no   unknown   6   may 2008
## 370     370  23       student   single secondary      no     157     yes   no   unknown   6   may 2008
## 371     371  34      services  married secondary      no      22     yes   no   unknown   6   may 2008
## 372     372  38        admin.  married secondary      no      46     yes  yes   unknown   6   may 2008
## 373     373  37   blue-collar  married secondary      no    1293      no   no   unknown   6   may 2008
## 374     374  25        admin.   single secondary      no     122     yes   no   unknown   6   may 2008
## 375     375  48   blue-collar  married   unknown      no     131     yes   no   unknown   6   may 2008
## 376     376  49   blue-collar   single secondary      no     143     yes   no   unknown   6   may 2008
## 377     377  38        admin.   single secondary      no     393      no   no   unknown   6   may 2008
## 378     378  43   blue-collar  married   primary      no      98     yes   no   unknown   6   may 2008
## 379     379  33    management  married  tertiary      no       0     yes   no   unknown   6   may 2008
## 380     380  55   blue-collar  married secondary      no     224     yes   no   unknown   6   may 2008
## 381     381  38   blue-collar  married secondary      no     757     yes   no   unknown   6   may 2008
## 382     382  49      services  married secondary      no     245     yes  yes   unknown   6   may 2008
## 383     383  40    management  married secondary      no    8486      no   no   unknown   6   may 2008
## 384     384  43        admin.  married   unknown      no     350      no   no   unknown   6   may 2008
## 385     385  38   blue-collar  married secondary      no      20     yes   no   unknown   6   may 2008
## 386     386  58      services  married secondary      no    1667     yes  yes   unknown   6   may 2008
## 387     387  57    technician  married   unknown      no     345     yes   no   unknown   6   may 2008
## 388     388  32    unemployed  married secondary      no      10     yes   no   unknown   6   may 2008
## 389     389  56    management  married  tertiary      no     830     yes  yes   unknown   6   may 2008
## 390     390  58   blue-collar divorced   unknown      no      29     yes   no   unknown   6   may 2008
## 391     391  60       retired divorced secondary      no     545     yes   no   unknown   6   may 2008
## 392     392  37    technician  married  tertiary      no    8730     yes   no   unknown   6   may 2008
## 393     393  46    technician divorced  tertiary      no     477     yes   no   unknown   6   may 2008
## 394     394  27        admin.  married secondary      no       4     yes   no   unknown   6   may 2008
## 395     395  43   blue-collar  married secondary      no    1205     yes   no   unknown   6   may 2008
## 396     396  32    technician   single secondary      no       0     yes  yes   unknown   6   may 2008
## 397     397  40        admin.   single secondary      no     263     yes   no   unknown   6   may 2008
## 398     398  38        admin.  married secondary      no       1      no   no   unknown   6   may 2008
## 399     399  34   blue-collar  married secondary      no     283      no  yes   unknown   6   may 2008
## 400     400  47   blue-collar  married   primary      no     206     yes   no   unknown   6   may 2008
## 401     401  42     housemaid  married   primary      no      17     yes   no   unknown   6   may 2008
## 402     402  48    technician  married secondary      no     141     yes  yes   unknown   6   may 2008
## 403     403  29 self-employed   single  tertiary      no      16     yes   no   unknown   6   may 2008
## 404     404  50      services  married secondary      no     206     yes   no   unknown   6   may 2008
## 405     405  52    technician  married   unknown      no       7      no   no   unknown   6   may 2008
## 406     406  50    management  married  tertiary      no       0      no   no   unknown   6   may 2008
## 407     407  58       retired  married  tertiary      no       0      no   no   unknown   6   may 2008
## 408     408  46   blue-collar divorced   primary      no    1927     yes   no   unknown   6   may 2008
## 409     409  38    technician  married secondary      no     284     yes   no   unknown   6   may 2008
## 410     410  46   blue-collar  married secondary      no    1660     yes   no   unknown   6   may 2008
## 411     411  32      services   single secondary      no     406     yes   no   unknown   6   may 2008
## 412     412  51   blue-collar  married   primary      no     230     yes   no   unknown   6   may 2008
## 413     413  39        admin.   single secondary      no     -25     yes   no   unknown   6   may 2008
## 414     414  48        admin.  married secondary      no     182     yes   no   unknown   6   may 2008
## 415     415  36  entrepreneur  married  tertiary      no    1169     yes   no   unknown   6   may 2008
## 416     416  34        admin. divorced secondary      no      67     yes   no   unknown   6   may 2008
## 417     417  40    technician  married secondary      no      77      no   no   unknown   6   may 2008
## 418     418  43    unemployed  married secondary      no       0     yes   no   unknown   6   may 2008
## 419     419  52   blue-collar divorced   primary      no      55     yes  yes   unknown   6   may 2008
## 420     420  33    technician  married secondary     yes      72     yes   no   unknown   6   may 2008
## 421     421  49    management   single  tertiary      no     163     yes   no   unknown   6   may 2008
## 422     422  32    management   single  tertiary      no     151     yes   no   unknown   6   may 2008
## 423     423  39        admin.   single secondary      no     113     yes   no   unknown   6   may 2008
## 424     424  40   blue-collar  married secondary      no       0     yes   no   unknown   6   may 2008
## 425     425  38    technician   single  tertiary      no       9     yes   no   unknown   6   may 2008
## 426     426  43    management  married secondary      no     375     yes   no   unknown   6   may 2008
## 427     427  39      services  married secondary      no    1142     yes   no   unknown   6   may 2008
## 428     428  54   blue-collar  married   primary      no    2102     yes   no   unknown   6   may 2008
## 429     429  38    technician   single  tertiary      no    4325     yes   no   unknown   6   may 2008
## 430     430  40   blue-collar  married secondary      no     217     yes   no   unknown   6   may 2008
## 431     431  55        admin.  married secondary      no     131     yes   no   unknown   6   may 2008
## 432     432  42    management  married  tertiary      no    1680     yes   no   unknown   6   may 2008
## 433     433  39   blue-collar  married secondary      no       0     yes   no   unknown   6   may 2008
## 434     434  40   blue-collar  married   primary      no      46     yes   no   unknown   6   may 2008
## 435     435  32   blue-collar  married secondary      no     320     yes   no   unknown   6   may 2008
## 436     436  55        admin.  married secondary      no     183     yes   no   unknown   6   may 2008
## 437     437  45   blue-collar  married secondary      no      39      no   no   unknown   6   may 2008
## 438     438  35    management   single  tertiary      no     560     yes   no   unknown   6   may 2008
## 439     439  58    technician divorced secondary      no     469      no   no   unknown   6   may 2008
## 440     440  35        admin.  married secondary      no     530     yes   no   unknown   6   may 2008
## 441     441  49      services  married   primary      no      61     yes   no   unknown   6   may 2008
## 442     442  34    technician   single  tertiary      no     242     yes   no   unknown   6   may 2008
## 443     443  36   blue-collar  married secondary      no     139     yes   no   unknown   6   may 2008
## 444     444  24 self-employed   single secondary      no       0     yes   no   unknown   6   may 2008
## 445     445  34    technician  married secondary      no     367     yes   no   unknown   6   may 2008
## 446     446  51        admin. divorced secondary      no     228     yes   no   unknown   6   may 2008
## 447     447  39    technician   single   unknown      no   45248     yes   no   unknown   6   may 2008
## 448     448  50 self-employed  married   unknown      no     -84     yes   no   unknown   6   may 2008
## 449     449  32      services   single secondary      no     310     yes   no   unknown   6   may 2008
## 450     450  42   blue-collar  married   unknown      no     132     yes   no   unknown   6   may 2008
## 451     451  50    technician  married secondary      no     797     yes   no   unknown   6   may 2008
## 452     452  40      services  married secondary      no      71      no   no   unknown   6   may 2008
## 453     453  46    management divorced   unknown      no       2     yes   no   unknown   6   may 2008
## 454     454  37    management  married  tertiary      no     231     yes  yes   unknown   6   may 2008
## 455     455  34   blue-collar  married secondary      no     270     yes  yes   unknown   6   may 2008
## 456     456  44   blue-collar  married secondary      no     274     yes  yes   unknown   6   may 2008
## 457     457  40        admin.   single secondary      no    -109     yes  yes   unknown   6   may 2008
## 458     458  37    technician  married secondary      no       1     yes   no   unknown   6   may 2008
## 459     459  33   blue-collar   single secondary     yes     -60      no   no   unknown   6   may 2008
## 460     460  35   blue-collar  married secondary      no      89     yes   no   unknown   6   may 2008
## 461     461  58   blue-collar divorced secondary      no     -11      no   no   unknown   6   may 2008
## 462     462  39   blue-collar  married   primary      no       0     yes   no   unknown   6   may 2008
## 463     463  43   blue-collar  married secondary      no    -509     yes   no   unknown   6   may 2008
## 464     464  39    unemployed  married   primary      no     408     yes   no   unknown   6   may 2008
## 465     465  36      services   single   primary      no      58     yes   no   unknown   6   may 2008
## 466     466  57       retired   single secondary      no    1640      no  yes   unknown   6   may 2008
## 467     467  36        admin.   single secondary      no      20     yes   no   unknown   6   may 2008
## 468     468  50   blue-collar  married   primary      no      71     yes   no   unknown   6   may 2008
## 469     469  55   blue-collar  married secondary      no      52     yes   no   unknown   6   may 2008
## 470     470  44 self-employed  married  tertiary      no     292     yes   no   unknown   6   may 2008
## 471     471  44      services divorced secondary      no     424     yes   no   unknown   6   may 2008
## 472     472  39     housemaid   single   primary      no     109     yes   no   unknown   6   may 2008
## 473     473  46   blue-collar  married   unknown      no    1044     yes   no   unknown   6   may 2008
## 474     474  39   blue-collar  married secondary      no     983     yes   no   unknown   6   may 2008
## 475     475  34        admin.  married secondary      no     869      no   no   unknown   6   may 2008
## 476     476  40   blue-collar  married   primary      no     668     yes   no   unknown   6   may 2008
## 477     477  50    management  married  tertiary      no     964     yes   no   unknown   6   may 2008
## 478     478  31    management   single secondary      no     301     yes   no   unknown   6   may 2008
## 479     479  37        admin.   single secondary      no     140     yes   no   unknown   6   may 2008
## 480     480  39    management   single secondary      no    1877     yes   no   unknown   6   may 2008
## 481     481  51   blue-collar  married   primary      no    1127     yes   no   unknown   6   may 2008
## 482     482  41    technician  married secondary      no     871     yes   no   unknown   6   may 2008
## 483     483  41    technician  married secondary      no     767     yes  yes   unknown   6   may 2008
## 484     484  43   blue-collar  married secondary      no       0      no   no   unknown   6   may 2008
## 485     485  30      services   single secondary      no     209     yes   no   unknown   6   may 2008
## 486     486  54    management divorced   primary      no       0      no   no   unknown   6   may 2008
## 487     487  43   blue-collar divorced secondary      no     110     yes  yes   unknown   6   may 2008
## 488     488  59    management divorced  tertiary      no     -76     yes  yes   unknown   6   may 2008
## 489     489  47    technician  married   unknown      no     178     yes   no   unknown   6   may 2008
## 490     490  40   blue-collar  married   primary      no     -66     yes   no   unknown   6   may 2008
## 491     491  32    technician  married secondary      no       0     yes   no   unknown   6   may 2008
## 492     492  29   blue-collar  married secondary      no       1     yes   no   unknown   6   may 2008
## 493     493  36   blue-collar  married secondary      no       0     yes   no   unknown   6   may 2008
## 494     494  55    unemployed  married  tertiary      no    5345      no   no   unknown   6   may 2008
## 495     495  30   blue-collar divorced secondary      no    -209     yes   no   unknown   6   may 2008
## 496     496  39        admin.   single secondary      no       0     yes   no   unknown   6   may 2008
## 497     497  39   blue-collar divorced secondary      no      42     yes   no   unknown   6   may 2008
## 498     498  50   blue-collar divorced secondary      no      41     yes   no   unknown   6   may 2008
## 499     499  44   blue-collar  married secondary      no     -99     yes   no   unknown   6   may 2008
## 500     500  37    technician   single secondary      no      17     yes   no   unknown   6   may 2008
## 501     501  46        admin.  married   primary      no     276     yes  yes   unknown   6   may 2008
## 502     502  32    technician   single   unknown      no    -170      no   no   unknown   6   may 2008
## 503     503  37    management   single  tertiary      no     230     yes  yes   unknown   6   may 2008
## 504     504  29   blue-collar  married secondary      no       9     yes   no   unknown   6   may 2008
## 505     505  41   blue-collar  married secondary      no     946     yes   no   unknown   6   may 2008
## 506     506  45   blue-collar  married   primary      no    1297     yes   no   unknown   6   may 2008
## 507     507  57       retired divorced secondary      no    -331     yes   no   unknown   6   may 2008
## 508     508  48   blue-collar   single secondary      no      44     yes   no   unknown   6   may 2008
## 509     509  60       retired  married secondary     yes      15      no   no   unknown   6   may 2008
## 510     510  26        admin.   single secondary      no     712     yes   no   unknown   6   may 2008
## 511     511  58       retired  married secondary      no    5435     yes   no   unknown   6   may 2008
## 512     512  34        admin.  married secondary      no     507     yes   no   unknown   6   may 2008
## 513     513  55    unemployed divorced secondary      no     387     yes   no   unknown   6   may 2008
## 514     514  41   blue-collar  married   primary      no       0     yes  yes   unknown   6   may 2008
## 515     515  50    management divorced secondary      no    1716     yes   no   unknown   6   may 2008
## 516     516  49  entrepreneur  married secondary      no     167     yes  yes   unknown   6   may 2008
## 517     517  44        admin.  married   unknown      no      40      no  yes   unknown   6   may 2008
## 518     518  44   blue-collar  married   primary      no     148     yes   no   unknown   6   may 2008
## 519     519  31    technician  married secondary      no      17     yes  yes   unknown   6   may 2008
## 520     520  34   blue-collar   single  tertiary      no    1011     yes   no   unknown   6   may 2008
## 521     521  46    management   single   unknown      no    1527     yes   no   unknown   6   may 2008
## 522     522  42    management  married  tertiary      no     744      no   no   unknown   6   may 2008
## 523     523  52        admin.  married secondary      no     484     yes   no   unknown   6   may 2008
## 524     524  29    management   single  tertiary      no       0     yes   no   unknown   6   may 2008
## 525     525  53       retired  married   primary      no     136     yes   no   unknown   6   may 2008
## 526     526  43   blue-collar  married secondary      no    1335     yes   no   unknown   6   may 2008
## 527     527  38    management  married secondary      no     517     yes   no   unknown   6   may 2008
## 528     528  46    management  married  tertiary      no     459     yes   no   unknown   6   may 2008
## 529     529  48    management divorced   unknown      no     549     yes   no   unknown   6   may 2008
## 530     530  30        admin. divorced secondary      no      83     yes  yes   unknown   6   may 2008
## 531     531  44   blue-collar  married   primary      no     213      no   no   unknown   6   may 2008
## 532     532  31     housemaid  married   primary      no     203     yes   no   unknown   6   may 2008
## 533     533  42      services   single secondary      no     518     yes   no   unknown   6   may 2008
## 534     534  40    management   single  tertiary      no    3877     yes   no   unknown   6   may 2008
## 535     535  52        admin.  married secondary      no    1236     yes   no   unknown   6   may 2008
## 536     536  45   blue-collar divorced secondary      no     756     yes   no   unknown   6   may 2008
## 537     537  48   blue-collar  married secondary      no     157     yes   no   unknown   6   may 2008
## 538     538  45   blue-collar  married   primary      no     -66     yes   no   unknown   6   may 2008
## 539     539  34   blue-collar  married   unknown      no     245     yes   no   unknown   6   may 2008
## 540     540  34   blue-collar  married   primary      no    -144     yes   no   unknown   6   may 2008
## 541     541  46   blue-collar  married secondary      no      71     yes   no   unknown   6   may 2008
## 542     542  49      services divorced secondary      no     505     yes   no   unknown   6   may 2008
## 543     543  50    technician  married   primary      no     249     yes   no   unknown   6   may 2008
## 544     544  34        admin.   single secondary      no       0     yes   no   unknown   6   may 2008
## 545     545  40    unemployed   single secondary      no      11     yes   no   unknown   6   may 2008
## 546     546  36        admin.  married secondary      no     639     yes   no   unknown   6   may 2008
## 547     547  59   blue-collar divorced   unknown      no     124     yes   no   unknown   6   may 2008
## 548     548  45   blue-collar  married secondary      no      82     yes   no   unknown   6   may 2008
## 549     549  36 self-employed  married  tertiary      no     107     yes   no   unknown   6   may 2008
## 550     550  56      services  married secondary      no     473     yes   no   unknown   6   may 2008
## 551     551  42      services divorced secondary      no     372     yes  yes   unknown   6   may 2008
## 552     552  30        admin.  married secondary      no      46     yes   no   unknown   6   may 2008
## 553     553  30       student   single  tertiary      no      34     yes   no   unknown   6   may 2008
## 554     554  47 self-employed  married   unknown      no     935     yes   no   unknown   6   may 2008
## 555     555  33   blue-collar  married secondary      no     -10     yes   no   unknown   6   may 2008
## 556     556  36        admin.  married secondary      no    -106     yes   no   unknown   6   may 2008
## 557     557  39      services divorced   primary      no     471     yes   no   unknown   6   may 2008
## 558     558  56        admin. divorced secondary      no     778     yes   no   unknown   6   may 2008
## 559     559  39   blue-collar divorced   unknown      no     170     yes   no   unknown   6   may 2008
## 560     560  42    technician  married secondary      no     315     yes   no   unknown   6   may 2008
## 561     561  52   blue-collar  married secondary      no    3165      no   no   unknown   6   may 2008
## 562     562  36        admin. divorced secondary      no     131     yes   no   unknown   6   may 2008
## 563     563  35  entrepreneur  married secondary     yes     204     yes   no   unknown   6   may 2008
## 564     564  47    technician  married secondary      no      83     yes   no   unknown   6   may 2008
## 565     565  59      services divorced secondary      no       0     yes  yes   unknown   6   may 2008
## 566     566  57   blue-collar  married   primary      no    5431     yes  yes   unknown   6   may 2008
## 567     567  38    management  married   unknown      no    1759     yes   no   unknown   6   may 2008
## 568     568  46    unemployed  married secondary      no    -125     yes   no   unknown   6   may 2008
## 569     569  34   blue-collar  married secondary      no       0      no   no   unknown   6   may 2008
## 570     570  28      services   single secondary      no    5090     yes   no   unknown   6   may 2008
## 571     571  38    technician  married   unknown      no     573     yes   no   unknown   6   may 2008
## 572     572  56   blue-collar  married secondary      no    1602     yes   no   unknown   6   may 2008
## 573     573  41   blue-collar   single   primary     yes    -137     yes  yes   unknown   6   may 2008
## 574     574  52    technician  married   unknown      no       0      no   no   unknown   6   may 2008
## 575     575  54      services  married secondary      no     193      no   no   unknown   6   may 2008
## 576     576  61       retired  married secondary      no     195     yes  yes   unknown   6   may 2008
## 577     577  53  entrepreneur  married secondary      no     288      no   no   unknown   6   may 2008
## 578     578  47    technician  married secondary      no      19     yes   no   unknown   6   may 2008
## 579     579  53   blue-collar  married   primary      no      25     yes   no   unknown   6   may 2008
## 580     580  46      services  married secondary      no     216     yes   no   unknown   6   may 2008
## 581     581  39   blue-collar divorced   primary      no     190     yes  yes   unknown   6   may 2008
## 582     582  56    technician divorced secondary      no      99     yes   no   unknown   6   may 2008
## 583     583  55      services divorced   primary      no    2298     yes   no   unknown   6   may 2008
## 584     584  44    management  married  tertiary      no      17     yes   no   unknown   6   may 2008
## 585     585  37    technician  married   primary      no       0     yes   no   unknown   6   may 2008
## 586     586  35   blue-collar  married   primary      no       0     yes   no   unknown   6   may 2008
## 587     587  55   blue-collar  married secondary      no     840     yes   no   unknown   6   may 2008
## 588     588  37      services  married secondary      no     358     yes   no   unknown   6   may 2008
## 589     589  30    technician   single secondary      no       0     yes   no   unknown   6   may 2008
## 590     590  37   blue-collar  married   primary      no    -325     yes  yes   unknown   6   may 2008
## 591     591  36    technician   single secondary      no     -15     yes   no   unknown   6   may 2008
## 592     592  38    technician  married secondary      no     581     yes   no   unknown   6   may 2008
## 593     593  41        admin. divorced   primary      no    4070     yes   no   unknown   6   may 2008
## 594     594  48       retired  married secondary      no      74      no  yes   unknown   6   may 2008
## 595     595  55      services divorced secondary      no     141     yes   no   unknown   6   may 2008
## 596     596  28      services divorced secondary      no      89      no   no   unknown   6   may 2008
## 597     597  54      services  married secondary     yes       0     yes   no   unknown   6   may 2008
## 598     598  30   blue-collar  married secondary      no     450      no   no   unknown   6   may 2008
## 599     599  48    technician  married  tertiary      no     310      no   no   unknown   6   may 2008
## 600     600  31 self-employed  married secondary      no       0     yes   no   unknown   6   may 2008
## 601     601  38   blue-collar  married secondary      no     384     yes   no   unknown   6   may 2008
## 602     602  37   blue-collar  married secondary      no     395     yes   no   unknown   6   may 2008
## 603     603  37      services   single   unknown      no    -118     yes   no   unknown   6   may 2008
## 604     604  56   blue-collar  married   primary      no       5     yes  yes   unknown   6   may 2008
## 605     605  51   blue-collar  married secondary      no      50     yes  yes   unknown   6   may 2008
## 606     606  39   blue-collar  married secondary      no     285     yes  yes   unknown   6   may 2008
## 607     607  49    technician  married   unknown      no      15      no   no   unknown   6   may 2008
## 608     608  51   blue-collar  married   primary      no     653     yes  yes   unknown   6   may 2008
## 609     609  43 self-employed  married secondary      no     918     yes   no   unknown   6   may 2008
## 610     610  32      services  married secondary      no     243     yes  yes   unknown   6   may 2008
## 611     611  29    technician   single  tertiary      no     405     yes   no   unknown   6   may 2008
## 612     612  48    management divorced  tertiary      no    1328     yes   no   unknown   6   may 2008
## 613     613  55      services  married   primary      no     255     yes   no   unknown   6   may 2008
## 614     614  53   blue-collar  married secondary      no    3397     yes   no   unknown   6   may 2008
## 615     615  47    technician  married   unknown      no    2106     yes   no   unknown   6   may 2008
## 616     616  39    management  married  tertiary      no    2877     yes   no   unknown   6   may 2008
## 617     617  31   blue-collar   single  tertiary      no      60     yes  yes   unknown   6   may 2008
## 618     618  39   blue-collar  married   primary      no    2226     yes   no   unknown   6   may 2008
## 619     619  40   blue-collar  married   primary      no    2880     yes   no   unknown   6   may 2008
## 620     620  40    technician   single   unknown      no      -5     yes   no   unknown   6   may 2008
## 621     621  48    technician  married secondary      no     147      no   no   unknown   6   may 2008
## 622     622  33    technician divorced secondary      no       7     yes  yes   unknown   6   may 2008
## 623     623  40    technician  married secondary      no     109     yes   no   unknown   6   may 2008
## 624     624  59       retired  married   primary      no    -119     yes   no   unknown   6   may 2008
## 625     625  30    technician  married secondary      no     484     yes   no   unknown   6   may 2008
## 626     626  31    management   single  tertiary      no    1852     yes   no   unknown   6   may 2008
## 627     627  35    unemployed  married secondary      no     533     yes   no   unknown   6   may 2008
## 628     628  54    technician divorced secondary      no      21     yes   no   unknown   6   may 2008
## 629     629  34        admin.   single   unknown      no    2434     yes   no   unknown   6   may 2008
## 630     630  32    technician  married secondary      no      90     yes  yes   unknown   6   may 2008
## 631     631  56        admin. divorced   unknown      no    4246     yes   no   unknown   6   may 2008
## 632     632  32        admin.   single  tertiary      no     395     yes   no   unknown   6   may 2008
## 633     633  42   blue-collar  married   primary      no      15     yes   no   unknown   6   may 2008
## 634     634  33      services  married  tertiary      no      85      no   no   unknown   6   may 2008
## 635     635  52  entrepreneur  married  tertiary      no    -184     yes  yes   unknown   6   may 2008
## 636     636  52      services  married secondary      no     660      no   no   unknown   6   may 2008
## 637     637  52   blue-collar divorced   primary     yes    -183     yes   no   unknown   6   may 2008
## 638     638  30    unemployed divorced secondary      no    1144     yes   no   unknown   6   may 2008
## 639     639  44      services divorced secondary      no       1     yes   no   unknown   6   may 2008
## 640     640  35        admin.  married secondary      no      69     yes  yes   unknown   6   may 2008
## 641     641  55    management   single secondary      no     220     yes   no   unknown   6   may 2008
## 642     642  33   blue-collar  married   primary      no     332     yes   no   unknown   6   may 2008
## 643     643  37   blue-collar   single secondary      no     240     yes   no   unknown   6   may 2008
## 644     644  42    technician   single secondary      no       0     yes   no   unknown   6   may 2008
## 645     645  43    unemployed  married secondary      no       0     yes   no   unknown   6   may 2008
## 646     646  38  entrepreneur  married  tertiary      no     898     yes   no   unknown   6   may 2008
## 647     647  37    technician  married secondary      no     123     yes  yes   unknown   6   may 2008
## 648     648  31       student   single secondary      no     252     yes   no   unknown   6   may 2008
## 649     649  41    management  married  tertiary      no      65     yes   no   unknown   6   may 2008
## 650     650  41    technician  married secondary      no    -366     yes  yes   unknown   6   may 2008
## 651     651  29       student   single secondary      no     209     yes   no   unknown   6   may 2008
## 652     652  38        admin.   single secondary      no     221     yes   no   unknown   6   may 2008
## 653     653  44 self-employed divorced  tertiary      no       4     yes   no   unknown   6   may 2008
## 654     654  39        admin.  married secondary      no     104     yes   no   unknown   6   may 2008
## 655     655  28    technician   single secondary      no     312     yes   no   unknown   6   may 2008
## 656     656  33   blue-collar  married secondary      no    -349     yes   no   unknown   6   may 2008
## 657     657  41      services  married   unknown      no       4      no   no   unknown   6   may 2008
## 658     658  40   blue-collar  married   primary      no    -322     yes  yes   unknown   6   may 2008
## 659     659  29        admin.  married secondary      no    -150     yes   no   unknown   6   may 2008
## 660     660  38    management  married   unknown      no    1349     yes   no   unknown   6   may 2008
## 661     661  32        admin.  married  tertiary      no     281     yes   no   unknown   6   may 2008
## 662     662  45      services  married secondary      no    1259     yes   no   unknown   6   may 2008
## 663     663  33        admin.   single secondary      no     101     yes   no   unknown   6   may 2008
## 664     664  34   blue-collar  married secondary      no     848     yes   no   unknown   6   may 2008
## 665     665  41  entrepreneur  married   unknown      no      89     yes   no   unknown   6   may 2008
## 666     666  41   blue-collar  married secondary      no     140     yes   no   unknown   6   may 2008
## 667     667  35        admin.   single secondary      no     148     yes   no   unknown   6   may 2008
## 668     668  40    technician   single secondary      no     200     yes   no   unknown   6   may 2008
## 669     669  60 self-employed  married   primary      no      46     yes   no   unknown   6   may 2008
## 670     670  47      services divorced secondary      no     201     yes   no   unknown   6   may 2008
## 671     671  46   blue-collar  married   primary      no     530     yes   no   unknown   6   may 2008
## 672     672  31   blue-collar   single secondary      no       0     yes   no   unknown   6   may 2008
## 673     673  49 self-employed  married secondary      no       1     yes   no   unknown   6   may 2008
## 674     674  29   blue-collar  married secondary      no      43     yes   no   unknown   6   may 2008
## 675     675  31    management   single  tertiary      no    -173     yes   no   unknown   6   may 2008
## 676     676  38    management  married  tertiary      no     389     yes   no   unknown   6   may 2008
## 677     677  37   blue-collar  married   primary      no     215     yes  yes   unknown   6   may 2008
## 678     678  35    technician  married secondary      no    -131     yes   no   unknown   6   may 2008
## 679     679  31    management   single secondary      no     783     yes   no   unknown   6   may 2008
## 680     680  41        admin.  married secondary      no       0     yes   no   unknown   6   may 2008
## 681     681  46      services  married   unknown      no      80     yes   no   unknown   6   may 2008
## 682     682  40      services divorced secondary      no     105     yes   no   unknown   6   may 2008
## 683     683  29        admin.  married secondary      no     182     yes  yes   unknown   6   may 2008
## 684     684  49        admin.  married secondary      no      82     yes   no   unknown   6   may 2008
## 685     685  42    management  married  tertiary      no       0     yes   no   unknown   6   may 2008
## 686     686  54      services  married secondary      no     510     yes   no   unknown   6   may 2008
## 687     687  40    management   single  tertiary      no     242     yes   no   unknown   6   may 2008
## 688     688  53        admin.  married secondary      no     244     yes  yes   unknown   6   may 2008
## 689     689  49    management  married  tertiary      no      92     yes   no   unknown   6   may 2008
## 690     690  40   blue-collar  married   primary     yes       0     yes   no   unknown   6   may 2008
## 691     691  29       student   single secondary      no     948     yes   no   unknown   6   may 2008
## 692     692  36   blue-collar  married   primary      no      23     yes   no   unknown   6   may 2008
## 693     693  37    technician  married secondary      no     710     yes   no   unknown   6   may 2008
## 694     694  39      services  married secondary      no    1205     yes   no   unknown   6   may 2008
## 695     695  36    technician  married secondary      no     368     yes  yes   unknown   6   may 2008
## 696     696  44  entrepreneur  married  tertiary      no    1631     yes   no   unknown   6   may 2008
## 697     697  40        admin.  married secondary      no       6     yes   no   unknown   6   may 2008
## 698     698  49   blue-collar  married secondary      no      26     yes   no   unknown   6   may 2008
## 699     699  30    technician   single   unknown      no     -48     yes   no   unknown   6   may 2008
## 700     700  57    management  married  tertiary      no    2142     yes   no   unknown   6   may 2008
## 701     701  24      services   single secondary      no      77     yes  yes   unknown   6   may 2008
## 702     702  46   blue-collar  married   unknown      no     401     yes   no   unknown   6   may 2008
## 703     703  33        admin.  married secondary      no      21      no   no   unknown   6   may 2008
## 704     704  43      services divorced secondary      no       0     yes   no   unknown   6   may 2008
## 705     705  43        admin.   single secondary      no    -497     yes   no   unknown   6   may 2008
## 706     706  40   blue-collar divorced   primary      no     369      no   no   unknown   6   may 2008
## 707     707  44    technician   single   unknown      no      78     yes   no   unknown   6   may 2008
## 708     708  35    technician   single  tertiary      no     226     yes  yes   unknown   6   may 2008
## 709     709  47    technician  married secondary      no     503     yes   no   unknown   6   may 2008
## 710     710  33   blue-collar  married secondary      no     372     yes   no   unknown   6   may 2008
## 711     711  31        admin.  married secondary      no       0     yes  yes   unknown   6   may 2008
## 712     712  40   blue-collar divorced secondary      no       0     yes   no   unknown   6   may 2008
## 713     713  36  entrepreneur  married  tertiary      no     125     yes   no   unknown   6   may 2008
## 714     714  56       retired divorced   primary      no       4     yes   no   unknown   6   may 2008
## 715     715  40        admin.   single   unknown      no     419     yes   no   unknown   6   may 2008
## 716     716  41        admin. divorced secondary      no     322     yes   no   unknown   6   may 2008
## 717     717  53       retired  married secondary      no     303     yes   no   unknown   6   may 2008
## 718     718  39   blue-collar  married secondary      no     607     yes   no   unknown   6   may 2008
## 719     719  44   blue-collar divorced secondary      no     579     yes   no   unknown   6   may 2008
## 720     720  38        admin.  married secondary      no    3047     yes   no   unknown   6   may 2008
## 721     721  54    technician divorced secondary      no      83     yes   no   unknown   6   may 2008
## 722     722  58    management  married  tertiary      no      68     yes   no   unknown   6   may 2008
## 723     723  52   blue-collar  married   primary      no      58     yes   no   unknown   6   may 2008
## 724     724  28        admin.   single secondary      no     251     yes   no   unknown   6   may 2008
## 725     725  36   blue-collar  married secondary      no     688     yes   no   unknown   6   may 2008
## 726     726  60       retired  married   primary      no     364     yes   no   unknown   6   may 2008
## 727     727  42      services divorced secondary      no      55     yes   no   unknown   6   may 2008
## 728     728  42        admin.  married secondary      no     101     yes   no   unknown   6   may 2008
## 729     729  44    management  married  tertiary      no     105     yes   no   unknown   6   may 2008
## 730     730  51   blue-collar divorced   primary      no     325     yes   no   unknown   6   may 2008
## 731     731  49   blue-collar  married   primary      no     198     yes   no   unknown   6   may 2008
## 732     732  47  entrepreneur  married   unknown      no     209     yes   no   unknown   6   may 2008
## 733     733  37   blue-collar  married secondary      no     183     yes   no   unknown   6   may 2008
## 734     734  34    management  married  tertiary      no     105     yes   no   unknown   6   may 2008
## 735     735  35      services  married secondary      no     109     yes   no   unknown   6   may 2008
## 736     736  35   blue-collar   single secondary      no     376     yes  yes   unknown   6   may 2008
## 737     737  40   blue-collar  married   primary      no      -7     yes   no   unknown   6   may 2008
## 738     738  55    technician  married secondary      no       0      no   no   unknown   6   may 2008
## 739     739  55       retired  married secondary      no     143     yes   no   unknown   6   may 2008
## 740     740  35    management   single  tertiary      no     550     yes   no   unknown   6   may 2008
## 741     741  57   blue-collar  married   primary      no     162     yes   no   unknown   6   may 2008
## 742     742  53    management  married  tertiary      no     115     yes   no   unknown   6   may 2008
## 743     743  41   blue-collar  married   primary      no     512     yes   no   unknown   6   may 2008
## 744     744  57   blue-collar  married   unknown      no     807     yes   no   unknown   6   may 2008
## 745     745  45   blue-collar  married   unknown      no     248     yes   no   unknown   6   may 2008
## 746     746  43   blue-collar  married   primary      no    1211     yes   no   unknown   6   may 2008
## 747     747  56 self-employed  married   unknown      no       7      no   no   unknown   6   may 2008
## 748     748  31  entrepreneur  married  tertiary      no     281     yes   no   unknown   6   may 2008
## 749     749  37   blue-collar   single secondary      no      88     yes   no   unknown   6   may 2008
## 750     750  30    management  married  tertiary      no      32     yes   no   unknown   6   may 2008
## 751     751  30        admin.   single secondary      no     115     yes   no   unknown   6   may 2008
## 752     752  54   blue-collar  married secondary      no     254     yes   no   unknown   6   may 2008
## 753     753  36    management  married  tertiary      no     144     yes   no   unknown   6   may 2008
## 754     754  55    unemployed  married  tertiary      no     383      no   no   unknown   6   may 2008
## 755     755  37        admin.   single secondary      no     569     yes  yes   unknown   6   may 2008
## 756     756  38     housemaid  married secondary      no       0     yes   no   unknown   6   may 2008
## 757     757  48        admin.  married secondary      no    3754     yes   no   unknown   6   may 2008
## 758     758  55     housemaid divorced  tertiary      no    6920     yes   no   unknown   6   may 2008
## 759     759  59      services  married secondary      no     307     yes  yes   unknown   6   may 2008
## 760     760  37    technician  married secondary      no    -421     yes   no   unknown   6   may 2008
## 761     761  33   blue-collar divorced secondary      no      60      no   no   unknown   6   may 2008
## 762     762  44   blue-collar  married   primary      no      67     yes   no   unknown   6   may 2008
## 763     763  57    technician  married secondary      no     402     yes   no   unknown   6   may 2008
## 764     764  30 self-employed   single  tertiary      no     800      no   no   unknown   6   may 2008
## 765     765  42    technician  married  tertiary      no     239     yes  yes   unknown   6   may 2008
## 766     766  51   blue-collar divorced secondary      no     421     yes   no   unknown   6   may 2008
## 767     767  44        admin. divorced secondary      no     161     yes   no   unknown   7   may 2008
## 768     768  46    technician  married secondary     yes     289      no   no   unknown   7   may 2008
## 769     769  29       student   single secondary      no     110     yes   no   unknown   7   may 2008
## 770     770  39   blue-collar  married   primary      no     245     yes   no   unknown   7   may 2008
## 771     771  42      services  married secondary      no       0     yes   no   unknown   7   may 2008
## 772     772  50   blue-collar  married   primary      no     156     yes   no   unknown   7   may 2008
## 773     773  42    technician   single secondary      no       0     yes   no   unknown   7   may 2008
## 774     774  39        admin.  married secondary      no      20     yes   no   unknown   7   may 2008
## 775     775  55    technician   single  tertiary      no      92     yes   no   unknown   7   may 2008
## 776     776  46      services  married secondary      no      89     yes   no   unknown   7   may 2008
## 777     777  42   blue-collar  married secondary      no     166     yes   no   unknown   7   may 2008
## 778     778  45    management  married  tertiary      no     103     yes   no   unknown   7   may 2008
## 779     779  43   blue-collar  married   primary      no    -454     yes   no   unknown   7   may 2008
## 780     780  42        admin.  married secondary      no     445     yes   no   unknown   7   may 2008
## 781     781  30        admin.  married secondary      no       4      no   no   unknown   7   may 2008
## 782     782  47   blue-collar  married secondary      no    1001     yes   no   unknown   7   may 2008
## 783     783  51      services divorced secondary      no     -69     yes   no   unknown   7   may 2008
## 784     784  38    technician   single secondary      no      42     yes   no   unknown   7   may 2008
## 785     785  57    technician  married   unknown      no    1617     yes   no   unknown   7   may 2008
## 786     786  42    management divorced  tertiary      no     221     yes   no   unknown   7   may 2008
## 787     787  32    technician divorced secondary      no     210     yes  yes   unknown   7   may 2008
## 788     788  46    management  married  tertiary      no       0      no   no   unknown   7   may 2008
## 789     789  29       student   single  tertiary      no     185     yes   no   unknown   7   may 2008
## 790     790  59       retired  married secondary      no     836     yes   no   unknown   7   may 2008
## 791     791  32   blue-collar   single secondary      no     301     yes   no   unknown   7   may 2008
## 792     792  44   blue-collar  married   primary      no     503     yes   no   unknown   7   may 2008
## 793     793  40       retired  married   primary      no     407     yes   no   unknown   7   may 2008
## 794     794  31   blue-collar   single secondary      no      53     yes   no   unknown   7   may 2008
## 795     795  46 self-employed  married  tertiary      no    2303     yes   no   unknown   7   may 2008
## 796     796  43    management  married  tertiary      no     144     yes   no   unknown   7   may 2008
## 797     797  34      services  married secondary      no     205     yes   no   unknown   7   may 2008
## 798     798  39    management  married  tertiary      no     305     yes   no   unknown   7   may 2008
## 799     799  30   blue-collar divorced secondary      no     251     yes  yes   unknown   7   may 2008
## 800     800  56       retired  married secondary      no       0     yes   no   unknown   7   may 2008
## 801     801  29    technician  married secondary      no       8      no   no   unknown   7   may 2008
## 802     802  40   blue-collar divorced secondary      no     139     yes   no   unknown   7   may 2008
## 803     803  36      services  married secondary      no     184     yes   no   unknown   7   may 2008
## 804     804  37   blue-collar   single secondary      no     238     yes   no   unknown   7   may 2008
## 805     805  35        admin.  married secondary      no       0      no   no   unknown   7   may 2008
## 806     806  35   blue-collar  married   primary     yes       0     yes   no   unknown   7   may 2008
## 807     807  47      services  married   primary      no     222     yes   no   unknown   7   may 2008
## 808     808  31      services  married secondary      no     414     yes   no   unknown   7   may 2008
## 809     809  56       retired   single   primary      no     223     yes   no   unknown   7   may 2008
## 810     810  57    technician  married secondary      no     197      no   no   unknown   7   may 2008
## 811     811  36   blue-collar  married secondary      no    -251     yes   no   unknown   7   may 2008
## 812     812  45 self-employed divorced secondary      no    -139     yes   no   unknown   7   may 2008
## 813     813  47   blue-collar  married   unknown      no     733     yes   no   unknown   7   may 2008
## 814     814  29    technician   single  tertiary      no       0     yes   no   unknown   7   may 2008
## 815     815  57      services  married secondary      no       1      no   no   unknown   7   may 2008
## 816     816  45   blue-collar  married   primary      no      97     yes   no   unknown   7   may 2008
## 817     817  31   blue-collar   single   primary      no     435     yes   no   unknown   7   may 2008
## 818     818  31    management divorced  tertiary      no       0     yes   no   unknown   7   may 2008
## 819     819  37    technician   single  tertiary      no     147      no   no   unknown   7   may 2008
## 820     820  30    technician   single  tertiary      no       3     yes   no   unknown   7   may 2008
## 821     821  58      services divorced secondary      no    1109     yes  yes   unknown   7   may 2008
## 822     822  33      services  married secondary      no     404     yes   no   unknown   7   may 2008
## 823     823  39   blue-collar  married   primary      no     981     yes   no   unknown   7   may 2008
## 824     824  33   blue-collar   single   primary      no      95     yes   no   unknown   7   may 2008
## 825     825  34      services  married secondary      no     302     yes   no   unknown   7   may 2008
## 826     826  36      services divorced secondary      no    -290     yes  yes   unknown   7   may 2008
## 827     827  37      services   single secondary      no     259     yes   no   unknown   7   may 2008
## 828     828  35   blue-collar  married secondary      no     527     yes  yes   unknown   7   may 2008
## 829     829  55       retired  married secondary      no     102     yes   no   unknown   7   may 2008
## 830     830  34    management   single  tertiary      no     872     yes   no   unknown   7   may 2008
## 831     831  40    management divorced  tertiary      no     490     yes   no   unknown   7   may 2008
## 832     832  42   blue-collar   single   primary      no      19     yes   no   unknown   7   may 2008
## 833     833  37   blue-collar  married secondary      no      16     yes   no   unknown   7   may 2008
## 834     834  42    management  married  tertiary      no     386     yes   no   unknown   7   may 2008
## 835     835  35    technician   single secondary      no     539     yes   no   unknown   7   may 2008
## 836     836  44    technician divorced secondary      no    -329     yes   no   unknown   7   may 2008
## 837     837  30      services   single secondary      no    -174     yes   no   unknown   7   may 2008
## 838     838  45  entrepreneur  married secondary      no      68     yes   no   unknown   7   may 2008
## 839     839  35   blue-collar   single   unknown     yes    -532     yes   no   unknown   7   may 2008
## 840     840  36        admin. divorced secondary      no       0     yes   no   unknown   7   may 2008
## 841     841  49   blue-collar  married secondary      no      64     yes   no   unknown   7   may 2008
## 842     842  31   blue-collar   single secondary      no    1415     yes   no   unknown   7   may 2008
## 843     843  31    technician   single secondary      no     147     yes   no   unknown   7   may 2008
## 844     844  39   blue-collar  married secondary      no      72     yes   no   unknown   7   may 2008
## 845     845  37      services   single secondary      no    -196     yes   no   unknown   7   may 2008
## 846     846  33   blue-collar  married   primary      no     716     yes   no   unknown   7   may 2008
## 847     847  37    management  married  tertiary      no       0     yes   no   unknown   7   may 2008
## 848     848  42      services  married secondary      no    -246     yes   no   unknown   7   may 2008
## 849     849  56   blue-collar  married secondary      no    -203     yes   no   unknown   7   may 2008
## 850     850  37        admin.   single secondary      no     245     yes  yes   unknown   7   may 2008
## 851     851  36      services   single secondary      no     342     yes   no   unknown   7   may 2008
## 852     852  29    technician   single  tertiary      no       3     yes   no   unknown   7   may 2008
## 853     853  54    management  married  tertiary     yes    -248     yes  yes   unknown   7   may 2008
## 854     854  38   blue-collar  married secondary      no     376     yes   no   unknown   7   may 2008
## 855     855  43   blue-collar divorced secondary      no     370     yes   no   unknown   7   may 2008
## 856     856  47        admin.   single secondary      no     594     yes   no   unknown   7   may 2008
## 857     857  47   blue-collar  married secondary      no     387     yes   no   unknown   7   may 2008
## 858     858  38      services  married secondary      no     208     yes   no   unknown   7   may 2008
## 859     859  40   blue-collar  married secondary      no     563     yes   no   unknown   7   may 2008
## 860     860  33      services divorced secondary      no     392     yes  yes   unknown   7   may 2008
## 861     861  33       retired  married secondary      no     165      no   no   unknown   7   may 2008
## 862     862  53        admin. divorced   unknown      no     236     yes   no   unknown   7   may 2008
## 863     863  37      services  married   primary      no      52     yes   no   unknown   7   may 2008
## 864     864  40    management   single  tertiary      no    1265     yes   no   unknown   7   may 2008
## 865     865  37   blue-collar  married   primary      no     693     yes   no   unknown   7   may 2008
## 866     866  35    technician  married secondary      no     118     yes   no   unknown   7   may 2008
## 867     867  49   blue-collar  married   primary      no    3659     yes   no   unknown   7   may 2008
## 868     868  26   blue-collar   single secondary      no      24     yes   no   unknown   7   may 2008
## 869     869  38    management   single  tertiary      no     673     yes   no   unknown   7   may 2008
## 870     870  52 self-employed  married secondary      no     273      no   no   unknown   7   may 2008
## 871     871  33      services divorced secondary      no     327     yes   no   unknown   7   may 2008
## 872     872  31        admin.   single secondary      no     299     yes   no   unknown   7   may 2008
## 873     873  32   blue-collar  married secondary      no       0     yes   no   unknown   7   may 2008
## 874     874  35   blue-collar   single   primary      no     109     yes   no   unknown   7   may 2008
## 875     875  55    management divorced  tertiary      no     552      no   no   unknown   7   may 2008
## 876     876  32   blue-collar divorced   primary      no     473     yes   no   unknown   7   may 2008
## 877     877  37       unknown   single   unknown      no     414     yes   no   unknown   7   may 2008
## 878     878  45   blue-collar  married secondary      no     154     yes   no   unknown   7   may 2008
## 879     879  31    technician  married secondary      no     344     yes   no   unknown   7   may 2008
## 880     880  38        admin.  married secondary      no       8     yes   no   unknown   7   may 2008
## 881     881  37      services  married secondary      no      78     yes   no   unknown   7   may 2008
## 882     882  38   blue-collar  married secondary      no     266     yes   no   unknown   7   may 2008
## 883     883  33     housemaid  married  tertiary      no      98     yes  yes   unknown   7   may 2008
## 884     884  38   blue-collar  married   primary      no      83     yes   no   unknown   7   may 2008
## 885     885  37    management   single  tertiary     yes      45     yes   no   unknown   7   may 2008
## 886     886  29    unemployed  married  tertiary      no       8     yes   no   unknown   7   may 2008
## 887     887  42    management  married  tertiary      no     263     yes   no   unknown   7   may 2008
## 888     888  40   blue-collar  married secondary      no     306     yes   no   unknown   7   may 2008
## 889     889  32    management  married  tertiary      no     233     yes   no   unknown   7   may 2008
## 890     890  47    management divorced  tertiary      no     447      no  yes   unknown   7   may 2008
## 891     891  29       student   single secondary      no     872     yes   no   unknown   7   may 2008
## 892     892  53      services divorced   primary      no    -291     yes  yes   unknown   7   may 2008
## 893     893  31      services  married  tertiary      no     309     yes  yes   unknown   7   may 2008
## 894     894  59   blue-collar  married secondary      no     202     yes   no   unknown   7   may 2008
## 895     895  29  entrepreneur  married   primary      no      56     yes  yes   unknown   7   may 2008
## 896     896  59   blue-collar  married   primary      no     229     yes  yes   unknown   7   may 2008
## 897     897  44   blue-collar  married   primary      no     143     yes   no   unknown   7   may 2008
## 898     898  38        admin.   single secondary      no     100     yes   no   unknown   7   may 2008
## 899     899  49        admin.  married secondary      no     326     yes   no   unknown   7   may 2008
## 900     900  43   blue-collar  married secondary      no     167     yes   no   unknown   7   may 2008
## 901     901  52        admin.   single secondary      no     545     yes   no   unknown   7   may 2008
## 902     902  40        admin.  married secondary      no    2100     yes  yes   unknown   7   may 2008
## 903     903  32      services  married secondary      no       0     yes  yes   unknown   7   may 2008
## 904     904  47        admin.  married   primary      no     192     yes   no   unknown   7   may 2008
## 905     905  33    management  married  tertiary      no     442     yes   no   unknown   7   may 2008
## 906     906  35    management  married  tertiary      no     267     yes   no   unknown   7   may 2008
## 907     907  27      services   single secondary      no       0     yes   no   unknown   7   may 2008
## 908     908  50   blue-collar  married   primary      no     377     yes   no   unknown   7   may 2008
## 909     909  44       retired  married secondary      no    7624      no   no   unknown   7   may 2008
## 910     910  43 self-employed  married   primary      no      66     yes   no   unknown   7   may 2008
## 911     911  51   blue-collar  married   unknown      no      37     yes   no   unknown   7   may 2008
## 912     912  32        admin.   single secondary      no      64     yes   no   unknown   7   may 2008
## 913     913  47    management divorced  tertiary      no      34     yes   no   unknown   7   may 2008
## 914     914  34        admin. divorced secondary      no     627     yes   no   unknown   7   may 2008
## 915     915  57 self-employed  married   primary      no    1013     yes   no   unknown   7   may 2008
## 916     916  43        admin.   single secondary      no     140     yes   no   unknown   7   may 2008
## 917     917  40      services   single  tertiary      no    8823     yes   no   unknown   7   may 2008
## 918     918  28   blue-collar   single secondary      no      97     yes   no   unknown   7   may 2008
## 919     919  38   blue-collar  married   unknown      no       5     yes   no   unknown   7   may 2008
## 920     920  37    unemployed divorced secondary      no      74     yes   no   unknown   7   may 2008
## 921     921  44        admin.  married secondary      no   58544     yes   no   unknown   7   may 2008
## 922     922  41    technician  married secondary      no     169     yes   no   unknown   7   may 2008
## 923     923  37 self-employed  married  tertiary      no     444     yes   no   unknown   7   may 2008
## 924     924  30      services   single  tertiary      no     542     yes   no   unknown   7   may 2008
## 925     925  32   blue-collar  married secondary      no    -205     yes   no   unknown   7   may 2008
## 926     926  30    management   single  tertiary      no     112     yes   no   unknown   7   may 2008
## 927     927  35      services  married secondary      no      39      no   no   unknown   7   may 2008
## 928     928  55   blue-collar  married secondary      no    1268     yes   no   unknown   7   may 2008
## 929     929  52   blue-collar  married secondary      no     -98     yes   no   unknown   7   may 2008
## 930     930  33        admin.  married secondary      no      44     yes  yes   unknown   7   may 2008
## 931     931  55       retired  married   primary      no     -90     yes  yes   unknown   7   may 2008
## 932     932  33   blue-collar  married secondary      no       0      no   no   unknown   7   may 2008
## 933     933  40   blue-collar  married secondary     yes     -94     yes  yes   unknown   7   may 2008
## 934     934  39   blue-collar  married secondary     yes    -345     yes   no   unknown   7   may 2008
## 935     935  54   blue-collar  married secondary      no    -932     yes   no   unknown   7   may 2008
## 936     936  39   blue-collar  married   primary      no      20     yes   no   unknown   7   may 2008
## 937     937  49   blue-collar  married secondary      no      90     yes   no   unknown   7   may 2008
## 938     938  52        admin.  married secondary      no      31     yes   no   unknown   7   may 2008
## 939     939  27    management   single  tertiary      no     134     yes  yes   unknown   7   may 2008
## 940     940  26      services  married secondary      no       0     yes   no   unknown   7   may 2008
## 941     941  40   blue-collar  married secondary      no      61     yes   no   unknown   7   may 2008
## 942     942  47   blue-collar  married secondary     yes      -5     yes   no   unknown   7   may 2008
## 943     943  31      services   single secondary      no     -45      no   no   unknown   7   may 2008
## 944     944  53   blue-collar   single secondary      no     156     yes  yes   unknown   7   may 2008
## 945     945  31      services  married secondary      no     564     yes   no   unknown   7   may 2008
## 946     946  33        admin.  married secondary      no      -6     yes   no   unknown   7   may 2008
## 947     947  35      services  married secondary      no     528      no   no   unknown   7   may 2008
## 948     948  46  entrepreneur  married   unknown      no    1481     yes   no   unknown   7   may 2008
## 949     949  31    management  married secondary      no    2019      no   no   unknown   7   may 2008
## 950     950  35    technician   single secondary      no    1855     yes   no   unknown   7   may 2008
## 951     951  29    management  married secondary      no     147     yes  yes   unknown   7   may 2008
## 952     952  51    technician  married secondary      no     220     yes   no   unknown   7   may 2008
## 953     953  33   blue-collar  married   primary      no     198     yes   no   unknown   7   may 2008
## 954     954  37    management  married  tertiary      no     115      no   no   unknown   7   may 2008
## 955     955  43        admin.   single   unknown      no      87     yes   no   unknown   7   may 2008
## 956     956  42    technician  married  tertiary      no     644     yes   no   unknown   7   may 2008
## 957     957  28   blue-collar  married secondary      no     225     yes  yes   unknown   7   may 2008
## 958     958  57       retired  married secondary      no     502     yes   no   unknown   7   may 2008
## 959     959  38      services  married secondary      no     -32     yes   no   unknown   7   may 2008
## 960     960  39   blue-collar  married   primary      no     106     yes   no   unknown   7   may 2008
## 961     961  36    technician  married  tertiary      no     301     yes   no   unknown   7   may 2008
## 962     962  57       retired  married  tertiary      no     906     yes   no   unknown   7   may 2008
## 963     963  44    management  married   unknown      no     187     yes   no   unknown   7   may 2008
## 964     964  48      services divorced secondary      no     852     yes  yes   unknown   7   may 2008
## 965     965  46   blue-collar  married   primary      no     143     yes   no   unknown   7   may 2008
## 966     966  43        admin.  married secondary      no      71      no   no   unknown   7   may 2008
## 967     967  49      services  married secondary      no    1496     yes   no   unknown   7   may 2008
## 968     968  29      services   single secondary      no     703     yes   no   unknown   7   may 2008
## 969     969  53   blue-collar  married secondary      no     732     yes   no   unknown   7   may 2008
## 970     970  30      services   single secondary      no      21     yes   no   unknown   7   may 2008
## 971     971  41    management divorced secondary      no     276     yes   no   unknown   7   may 2008
## 972     972  33    technician  married secondary      no       0     yes   no   unknown   7   may 2008
## 973     973  47   blue-collar  married   primary      no     550     yes   no   unknown   7   may 2008
## 974     974  58       retired  married secondary      no     268     yes   no   unknown   7   may 2008
## 975     975  31    unemployed  married secondary      no    -825     yes   no   unknown   7   may 2008
## 976     976  38        admin.   single secondary      no     137     yes  yes   unknown   7   may 2008
## 977     977  60       retired  married secondary      no      42     yes  yes   unknown   7   may 2008
## 978     978  33    management   single  tertiary      no      54      no   no   unknown   7   may 2008
## 979     979  33    unemployed   single  tertiary      no    1716     yes   no   unknown   7   may 2008
## 980     980  52        admin.  married   primary      no     270     yes   no   unknown   7   may 2008
## 981     981  42   blue-collar  married   primary      no     803     yes   no   unknown   7   may 2008
## 982     982  30    technician   single secondary      no     102     yes   no   unknown   7   may 2008
## 983     983  33  entrepreneur divorced  tertiary      no     188     yes   no   unknown   7   may 2008
## 984     984  46        admin. divorced secondary      no     207     yes   no   unknown   7   may 2008
## 985     985  51   blue-collar  married   primary      no    1466     yes   no   unknown   7   may 2008
## 986     986  40    unemployed   single secondary      no     350     yes   no   unknown   7   may 2008
## 987     987  50        admin.  married secondary      no     159     yes   no   unknown   7   may 2008
## 988     988  42  entrepreneur  married  tertiary      no     157     yes  yes   unknown   7   may 2008
## 989     989  38    technician  married secondary      no       0      no   no   unknown   7   may 2008
## 990     990  36        admin.   single   primary      no      91     yes   no   unknown   7   may 2008
## 991     991  37    unemployed divorced   primary      no     849     yes   no   unknown   7   may 2008
## 992     992  33    management  married  tertiary      no     436     yes   no   unknown   7   may 2008
## 993     993  38   blue-collar   single secondary      no      -1     yes   no   unknown   7   may 2008
## 994     994  52   blue-collar  married  tertiary      no     297     yes   no   unknown   7   may 2008
## 995     995  29   blue-collar  married secondary      no     313     yes  yes   unknown   7   may 2008
## 996     996  37   blue-collar  married   primary      no     310     yes   no   unknown   7   may 2008
## 997     997  34        admin.  married secondary      no     475     yes   no   unknown   7   may 2008
## 998     998  43   blue-collar  married   primary      no      61     yes   no   unknown   7   may 2008
## 999     999  49      services  married secondary      no    1377     yes   no   unknown   7   may 2008
## 1000   1000  33    technician   single secondary      no      56      no   no   unknown   7   may 2008
## 1001   1001  47        admin.  married   unknown      no       0     yes   no   unknown   7   may 2008
## 1002   1002  50    technician  married secondary      no      73      no   no   unknown   7   may 2008
## 1003   1003  30   blue-collar   single   primary      no     660     yes   no   unknown   7   may 2008
## 1004   1004  44      services  married   primary      no     -79     yes   no   unknown   7   may 2008
## 1005   1005  44   blue-collar divorced secondary      no     558     yes   no   unknown   7   may 2008
## 1006   1006  30      services   single secondary      no     342     yes   no   unknown   7   may 2008
## 1007   1007  40   blue-collar  married   unknown      no      -4     yes   no   unknown   7   may 2008
## 1008   1008  41   blue-collar  married   unknown      no     225     yes   no   unknown   7   may 2008
## 1009   1009  34   blue-collar  married   primary      no     267     yes   no   unknown   7   may 2008
## 1010   1010  53      services  married   primary      no      46     yes   no   unknown   7   may 2008
## 1011   1011  35   blue-collar  married   primary      no     624     yes   no   unknown   7   may 2008
## 1012   1012  34    technician divorced secondary      no    1107     yes  yes   unknown   7   may 2008
## 1013   1013  39        admin.   single secondary      no     573     yes   no   unknown   7   may 2008
## 1014   1014  39    management   single  tertiary      no     406     yes   no   unknown   7   may 2008
## 1015   1015  52      services divorced secondary      no     220     yes   no   unknown   7   may 2008
## 1016   1016  34   blue-collar  married secondary      no    2308     yes   no   unknown   7   may 2008
## 1017   1017  37   blue-collar divorced   primary      no     139     yes   no   unknown   7   may 2008
## 1018   1018  39        admin.  married secondary      no     367     yes   no   unknown   7   may 2008
## 1019   1019  52  entrepreneur divorced   primary      no     278     yes   no   unknown   7   may 2008
## 1020   1020  35   blue-collar  married   primary      no     229     yes   no   unknown   7   may 2008
## 1021   1021  36  entrepreneur  married  tertiary      no    1722     yes   no   unknown   7   may 2008
## 1022   1022  48    technician  married secondary      no    -500     yes   no   unknown   7   may 2008
## 1023   1023  31        admin. divorced secondary      no     308     yes   no   unknown   7   may 2008
## 1024   1024  43    technician divorced  tertiary      no    1026     yes  yes   unknown   7   may 2008
## 1025   1025  43   blue-collar   single   primary      no     548     yes   no   unknown   7   may 2008
## 1026   1026  39   blue-collar  married secondary      no     356     yes  yes   unknown   7   may 2008
## 1027   1027  40    technician  married   primary      no     164     yes   no   unknown   7   may 2008
## 1028   1028  58    management  married  tertiary      no     211      no   no   unknown   7   may 2008
## 1029   1029  31   blue-collar  married   primary      no      19     yes   no   unknown   7   may 2008
## 1030   1030  41   blue-collar  married secondary      no     108     yes  yes   unknown   7   may 2008
## 1031   1031  37    management  married  tertiary      no     308     yes   no   unknown   7   may 2008
## 1032   1032  44      services divorced secondary      no       7     yes  yes   unknown   7   may 2008
## 1033   1033  37    technician  married  tertiary      no      16     yes  yes   unknown   7   may 2008
## 1034   1034  39   blue-collar  married   primary      no     867     yes   no   unknown   7   may 2008
## 1035   1035  41   blue-collar   single secondary      no     277     yes   no   unknown   7   may 2008
## 1036   1036  52   blue-collar divorced   primary      no     196     yes   no   unknown   7   may 2008
## 1037   1037  29   blue-collar   single   primary      no     365     yes  yes   unknown   7   may 2008
## 1038   1038  60   blue-collar divorced secondary      no    1310      no   no   unknown   7   may 2008
## 1039   1039  32    technician  married secondary      no     186      no   no   unknown   7   may 2008
## 1040   1040  50      services   single   primary      no     148     yes   no   unknown   7   may 2008
## 1041   1041  56   blue-collar  married   primary      no     862     yes  yes   unknown   7   may 2008
## 1042   1042  48        admin.  married secondary      no     359     yes   no   unknown   7   may 2008
## 1043   1043  29   blue-collar  married   primary      no     190      no   no   unknown   7   may 2008
## 1044   1044  40   blue-collar  married secondary      no       4     yes  yes   unknown   7   may 2008
## 1045   1045  42        admin. divorced secondary      no       0     yes   no   unknown   7   may 2008
## 1046   1046  34   blue-collar  married secondary      no      42     yes   no   unknown   7   may 2008
## 1047   1047  23    management   single  tertiary      no    2605     yes   no   unknown   7   may 2008
## 1048   1048  30    technician   single  tertiary      no      60     yes  yes   unknown   7   may 2008
## 1049   1049  51    management  married   primary      no      98     yes   no   unknown   7   may 2008
## 1050   1050  52    technician   single secondary      no    -181     yes   no   unknown   7   may 2008
## 1051   1051  45    technician  married secondary      no     118     yes   no   unknown   7   may 2008
## 1052   1052  41   blue-collar  married secondary      no     -15     yes   no   unknown   7   may 2008
## 1053   1053  27       student   single secondary      no     671     yes   no   unknown   7   may 2008
## 1054   1054  50   blue-collar  married secondary      no    1557     yes   no   unknown   7   may 2008
## 1055   1055  36   blue-collar  married   primary      no     -20     yes   no   unknown   7   may 2008
## 1056   1056  46   blue-collar  married   primary      no     323     yes   no   unknown   7   may 2008
## 1057   1057  44   blue-collar  married   primary      no    -171     yes   no   unknown   7   may 2008
## 1058   1058  47   blue-collar  married secondary      no     438     yes   no   unknown   7   may 2008
## 1059   1059  40   blue-collar  married secondary      no     316     yes   no   unknown   7   may 2008
## 1060   1060  36      services   single secondary      no     174     yes   no   unknown   7   may 2008
## 1061   1061  46   blue-collar  married secondary      no     442     yes   no   unknown   7   may 2008
## 1062   1062  58    technician  married secondary      no     786     yes   no   unknown   7   may 2008
## 1063   1063  30    technician divorced  tertiary      no    -317     yes   no   unknown   7   may 2008
## 1064   1064  43   blue-collar  married secondary      no     667     yes   no   unknown   7   may 2008
## 1065   1065  29      services   single secondary      no    -158     yes   no   unknown   7   may 2008
## 1066   1066  41    management  married  tertiary      no      72     yes   no   unknown   7   may 2008
## 1067   1067  44  entrepreneur  married   primary      no      58     yes   no   unknown   7   may 2008
## 1068   1068  44      services divorced secondary      no     396     yes  yes   unknown   7   may 2008
## 1069   1069  59   blue-collar  married   primary      no      10     yes   no   unknown   7   may 2008
## 1070   1070  39    management   single   unknown      no    2887     yes   no   unknown   7   may 2008
## 1071   1071  42    management  married secondary      no       0      no   no   unknown   7   may 2008
## 1072   1072  31        admin.  married secondary      no      89      no   no   unknown   7   may 2008
## 1073   1073  29       unknown   single   primary      no      50     yes   no   unknown   7   may 2008
## 1074   1074  39   blue-collar   single secondary      no      29     yes   no   unknown   7   may 2008
## 1075   1075  44   blue-collar  married   primary      no     420     yes   no   unknown   7   may 2008
## 1076   1076  49      services   single   primary      no     114     yes   no   unknown   7   may 2008
## 1077   1077  39     housemaid  married secondary      no     365     yes   no   unknown   7   may 2008
## 1078   1078  27   blue-collar   single secondary      no       0     yes   no   unknown   7   may 2008
## 1079   1079  56    management  married   primary      no     -24     yes   no   unknown   7   may 2008
## 1080   1080  43    technician  married  tertiary      no     743     yes   no   unknown   7   may 2008
## 1081   1081  37 self-employed  married   primary      no       0      no   no   unknown   7   may 2008
## 1082   1082  54    technician   single secondary      no      99     yes   no   unknown   7   may 2008
## 1083   1083  38   blue-collar  married secondary      no      22     yes  yes   unknown   7   may 2008
## 1084   1084  31   blue-collar  married   primary      no     251     yes   no   unknown   7   may 2008
## 1085   1085  34   blue-collar  married secondary      no     615     yes   no   unknown   7   may 2008
## 1086   1086  35        admin.  married   primary      no     136     yes   no   unknown   7   may 2008
## 1087   1087  44   blue-collar   single   unknown      no    2167     yes   no   unknown   7   may 2008
## 1088   1088  30   blue-collar  married secondary      no     309     yes   no   unknown   7   may 2008
## 1089   1089  51    technician  married secondary      no     221     yes   no   unknown   7   may 2008
## 1090   1090  37   blue-collar  married   primary      no     321     yes   no   unknown   7   may 2008
## 1091   1091  39   blue-collar  married  tertiary      no     -33     yes   no   unknown   7   may 2008
## 1092   1092  33    management   single  tertiary      no      76     yes   no   unknown   7   may 2008
## 1093   1093  37    management divorced  tertiary      no      42     yes   no   unknown   7   may 2008
## 1094   1094  46   blue-collar   single secondary      no      76     yes   no   unknown   7   may 2008
## 1095   1095  32        admin.  married secondary      no    1293     yes   no   unknown   7   may 2008
## 1096   1096  43  entrepreneur  married   primary      no     526     yes   no   unknown   7   may 2008
## 1097   1097  59     housemaid divorced   unknown      no     873     yes   no   unknown   7   may 2008
## 1098   1098  46        admin.  married   primary      no      40     yes   no   unknown   7   may 2008
## 1099   1099  47   blue-collar  married   primary      no     117     yes   no   unknown   7   may 2008
## 1100   1100  31      services   single secondary      no     671     yes   no   unknown   7   may 2008
## 1101   1101  30   blue-collar  married   primary      no     145     yes   no   unknown   7   may 2008
## 1102   1102  38   blue-collar  married   primary      no    1807      no   no   unknown   7   may 2008
## 1103   1103  44   blue-collar   single secondary      no    -212     yes  yes   unknown   7   may 2008
## 1104   1104  52    technician  married   unknown      no     133     yes   no   unknown   7   may 2008
## 1105   1105  29      services   single secondary      no     566      no   no   unknown   7   may 2008
## 1106   1106  43        admin.  married  tertiary      no    1924     yes   no   unknown   7   may 2008
## 1107   1107  47    technician  married   primary      no     145     yes   no   unknown   7   may 2008
## 1108   1108  43   blue-collar  married   primary      no     487     yes   no   unknown   7   may 2008
## 1109   1109  52   blue-collar divorced   primary      no     -57     yes   no   unknown   7   may 2008
## 1110   1110  32      services   single secondary      no      81     yes   no   unknown   7   may 2008
## 1111   1111  40        admin.   single secondary      no    -227     yes   no   unknown   7   may 2008
## 1112   1112  57    technician divorced secondary      no    2710     yes  yes   unknown   7   may 2008
## 1113   1113  30      services divorced secondary      no      98     yes   no   unknown   7   may 2008
## 1114   1114  48   blue-collar  married secondary      no    1230     yes  yes   unknown   7   may 2008
## 1115   1115  46   blue-collar  married secondary      no      78     yes  yes   unknown   7   may 2008
## 1116   1116  59       retired divorced   primary      no     137     yes  yes   unknown   7   may 2008
## 1117   1117  50   blue-collar  married   primary     yes     354     yes   no   unknown   7   may 2008
## 1118   1118  50   blue-collar divorced   primary      no     149     yes   no   unknown   7   may 2008
## 1119   1119  33   blue-collar divorced secondary      no     126     yes   no   unknown   7   may 2008
## 1120   1120  39    technician   single   unknown      no       0     yes   no   unknown   7   may 2008
## 1121   1121  57       retired divorced secondary      no    8266     yes   no   unknown   7   may 2008
## 1122   1122  49   blue-collar  married   unknown      no      51     yes   no   unknown   7   may 2008
## 1123   1123  41   blue-collar  married   primary      no     258     yes   no   unknown   7   may 2008
## 1124   1124  43    technician  married   primary      no     117     yes   no   unknown   7   may 2008
## 1125   1125  29    management  married  tertiary      no     199     yes  yes   unknown   7   may 2008
## 1126   1126  56      services  married   primary      no     219     yes   no   unknown   7   may 2008
## 1127   1127  46    technician  married secondary      no    1571     yes   no   unknown   7   may 2008
## 1128   1128  42   blue-collar  married   primary      no     223     yes   no   unknown   7   may 2008
## 1129   1129  36   blue-collar  married   primary      no     -79      no   no   unknown   7   may 2008
## 1130   1130  29      services  married   primary      no     321     yes   no   unknown   7   may 2008
## 1131   1131  43        admin.   single secondary      no    2527     yes   no   unknown   7   may 2008
## 1132   1132  48        admin.  married secondary      no       5     yes   no   unknown   7   may 2008
## 1133   1133  38   blue-collar   single   primary      no      20     yes   no   unknown   7   may 2008
## 1134   1134  46   blue-collar  married secondary      no    1045     yes  yes   unknown   7   may 2008
## 1135   1135  44   blue-collar  married secondary      no       1     yes   no   unknown   7   may 2008
## 1136   1136  28    management  married  tertiary      no       3     yes   no   unknown   7   may 2008
## 1137   1137  28   blue-collar  married   primary      no     -55     yes   no   unknown   7   may 2008
## 1138   1138  36    technician divorced secondary      no     141     yes   no   unknown   7   may 2008
## 1139   1139  37   blue-collar  married secondary      no     374     yes   no   unknown   7   may 2008
## 1140   1140  56    management  married   primary      no      93     yes   no   unknown   7   may 2008
## 1141   1141  46   blue-collar   single  tertiary      no     460     yes   no   unknown   7   may 2008
## 1142   1142  34      services divorced secondary      no      78     yes   no   unknown   7   may 2008
## 1143   1143  32  entrepreneur  married secondary      no     135     yes   no   unknown   7   may 2008
## 1144   1144  33    technician  married secondary      no     367     yes  yes   unknown   7   may 2008
## 1145   1145  36      services   single secondary      no     248     yes   no   unknown   7   may 2008
## 1146   1146  35      services  married secondary      no     630     yes   no   unknown   7   may 2008
## 1147   1147  44        admin.   single secondary      no     -30     yes   no   unknown   7   may 2008
## 1148   1148  37    technician  married secondary      no     157     yes   no   unknown   7   may 2008
## 1149   1149  48        admin. divorced secondary      no     268     yes   no   unknown   7   may 2008
## 1150   1150  38   blue-collar  married secondary      no     164     yes   no   unknown   7   may 2008
## 1151   1151  44    technician  married secondary      no     -97     yes   no   unknown   7   may 2008
## 1152   1152  31        admin. divorced secondary      no      53     yes   no   unknown   7   may 2008
## 1153   1153  35    management divorced  tertiary      no     788     yes   no   unknown   7   may 2008
## 1154   1154  54    technician divorced secondary      no    1904     yes  yes   unknown   7   may 2008
## 1155   1155  28        admin.   single secondary      no     260     yes   no   unknown   7   may 2008
## 1156   1156  38    unemployed  married   primary      no     447     yes   no   unknown   7   may 2008
## 1157   1157  48    technician  married secondary      no     720     yes   no   unknown   8   may 2008
## 1158   1158  31   blue-collar  married  tertiary      no    2827     yes   no   unknown   8   may 2008
## 1159   1159  59       retired  married   unknown      no       0      no   no   unknown   8   may 2008
## 1160   1160  29        admin.   single secondary      no    1117     yes   no   unknown   8   may 2008
## 1161   1161  28   blue-collar  married secondary      no     597     yes   no   unknown   8   may 2008
## 1162   1162  50   blue-collar  married   primary      no     362     yes   no   unknown   8   may 2008
## 1163   1163  31 self-employed   single  tertiary      no     120     yes   no   unknown   8   may 2008
## 1164   1164  32        admin.   single secondary      no      89     yes  yes   unknown   8   may 2008
## 1165   1165  30      services  married secondary      no     442     yes   no   unknown   8   may 2008
## 1166   1166  32    management   single  tertiary      no     111     yes   no   unknown   8   may 2008
## 1167   1167  29    technician   single secondary      no     247     yes   no   unknown   8   may 2008
## 1168   1168  30        admin. divorced secondary      no       1     yes   no   unknown   8   may 2008
## 1169   1169  34    management  married   primary      no       6     yes   no   unknown   8   may 2008
## 1170   1170  34   blue-collar   single secondary     yes    -947     yes   no   unknown   8   may 2008
## 1171   1171  41   blue-collar  married   primary      no     191     yes   no   unknown   8   may 2008
## 1172   1172  36   blue-collar  married secondary      no    -147     yes   no   unknown   8   may 2008
## 1173   1173  31    technician   single  tertiary      no     703     yes   no   unknown   8   may 2008
## 1174   1174  39   blue-collar  married   primary      no      70      no   no   unknown   8   may 2008
## 1175   1175  36    technician  married secondary      no      83     yes   no   unknown   8   may 2008
## 1176   1176  39   blue-collar  married secondary      no     125     yes   no   unknown   8   may 2008
## 1177   1177  37   blue-collar  married   primary      no     190     yes  yes   unknown   8   may 2008
## 1178   1178  52   blue-collar  married secondary      no      46     yes   no   unknown   8   may 2008
## 1179   1179  25    management   single  tertiary      no    1348     yes   no   unknown   8   may 2008
## 1180   1180  42    technician  married secondary      no     420     yes   no   unknown   8   may 2008
## 1181   1181  27      services divorced secondary      no      96     yes   no   unknown   8   may 2008
## 1182   1182  42   blue-collar  married   primary      no     271     yes   no   unknown   8   may 2008
## 1183   1183  29        admin. divorced secondary      no    1320     yes  yes   unknown   8   may 2008
## 1184   1184  38   blue-collar  married   primary      no      54     yes   no   unknown   8   may 2008
## 1185   1185  42  entrepreneur  married   primary      no     198     yes   no   unknown   8   may 2008
## 1186   1186  35 self-employed  married   primary      no    1094     yes   no   unknown   8   may 2008
## 1187   1187  41    management  married  tertiary      no     141     yes  yes   unknown   8   may 2008
## 1188   1188  57       retired  married   primary      no     207     yes   no   unknown   8   may 2008
## 1189   1189  36   blue-collar  married secondary      no    -206     yes   no   unknown   8   may 2008
## 1190   1190  56    management divorced  tertiary      no     177     yes   no   unknown   8   may 2008
## 1191   1191  33   blue-collar divorced   primary      no     176     yes   no   unknown   8   may 2008
## 1192   1192  41  entrepreneur divorced  tertiary      no    -413     yes   no   unknown   8   may 2008
## 1193   1193  33   blue-collar  married   primary      no     -81     yes   no   unknown   8   may 2008
## 1194   1194  35    management divorced  tertiary      no    3837     yes   no   unknown   8   may 2008
## 1195   1195  43    management  married  tertiary      no     870     yes  yes   unknown   8   may 2008
## 1196   1196  36        admin.   single secondary      no     206     yes   no   unknown   8   may 2008
## 1197   1197  37    technician  married secondary      no     316     yes   no   unknown   8   may 2008
## 1198   1198  51    management  married   primary     yes      57     yes  yes   unknown   8   may 2008
## 1199   1199  28     housemaid divorced   primary      no       1     yes   no   unknown   8   may 2008
## 1200   1200  43   blue-collar  married secondary     yes      -7      no   no   unknown   8   may 2008
## 1201   1201  32   blue-collar   single   primary      no     611     yes   no   unknown   8   may 2008
## 1202   1202  36  entrepreneur   single secondary      no     157     yes   no   unknown   8   may 2008
## 1203   1203  33    unemployed   single secondary      no     233     yes   no   unknown   8   may 2008
## 1204   1204  39        admin.  married secondary      no     419     yes  yes   unknown   8   may 2008
## 1205   1205  28   blue-collar  married secondary      no     134     yes   no   unknown   8   may 2008
## 1206   1206  26    technician   single secondary      no    2087      no   no   unknown   8   may 2008
## 1207   1207  40    technician  married  tertiary      no     103     yes   no   unknown   8   may 2008
## 1208   1208  44     housemaid  married secondary      no     281     yes   no   unknown   8   may 2008
## 1209   1209  34    management  married  tertiary      no     133     yes   no   unknown   8   may 2008
## 1210   1210  47   blue-collar  married   primary      no    1865     yes   no   unknown   8   may 2008
## 1211   1211  55   blue-collar   single  tertiary      no     325     yes   no   unknown   8   may 2008
## 1212   1212  48   blue-collar divorced   primary      no     -18     yes   no   unknown   8   may 2008
## 1213   1213  36   blue-collar   single   primary      no      49     yes   no   unknown   8   may 2008
## 1214   1214  31    management   single  tertiary      no    7444     yes  yes   unknown   8   may 2008
## 1215   1215  30    management   single  tertiary      no      59     yes  yes   unknown   8   may 2008
## 1216   1216  46   blue-collar  married   primary      no      45     yes   no   unknown   8   may 2008
## 1217   1217  30        admin.   single secondary      no     387     yes   no   unknown   8   may 2008
## 1218   1218  32   blue-collar   single secondary      no       5     yes  yes   unknown   8   may 2008
## 1219   1219  48   blue-collar   single   unknown      no      71     yes   no   unknown   8   may 2008
## 1220   1220  48        admin.   single secondary      no      96     yes   no   unknown   8   may 2008
## 1221   1221  36      services   single  tertiary      no      72     yes   no   unknown   8   may 2008
## 1222   1222  41        admin.   single secondary      no    1715     yes   no   unknown   8   may 2008
## 1223   1223  49        admin.   single   primary      no     181     yes   no   unknown   8   may 2008
## 1224   1224  26   blue-collar  married secondary     yes      20     yes   no   unknown   8   may 2008
## 1225   1225  38    management  married secondary      no      65     yes   no   unknown   8   may 2008
## 1226   1226  27       student   single secondary      no      81     yes   no   unknown   8   may 2008
## 1227   1227  51       retired  married secondary      no     226     yes  yes   unknown   8   may 2008
## 1228   1228  33        admin. divorced secondary      no    1128     yes   no   unknown   8   may 2008
## 1229   1229  53    unemployed  married secondary      no     582     yes   no   unknown   8   may 2008
## 1230   1230  36    technician  married secondary      no    5611     yes   no   unknown   8   may 2008
## 1231   1231  48    technician divorced secondary      no     177     yes   no   unknown   8   may 2008
## 1232   1232  27        admin.   single secondary      no     181     yes   no   unknown   8   may 2008
## 1233   1233  42    technician  married secondary      no       0     yes   no   unknown   8   may 2008
## 1234   1234  61   blue-collar  married   primary      no     734     yes   no   unknown   8   may 2008
## 1235   1235  31 self-employed  married  tertiary      no     322     yes   no   unknown   8   may 2008
## 1236   1236  37   blue-collar   single secondary      no     134     yes   no   unknown   8   may 2008
## 1237   1237  34  entrepreneur  married  tertiary      no   10350     yes   no   unknown   8   may 2008
## 1238   1238  55    technician  married   unknown      no      84     yes   no   unknown   8   may 2008
## 1239   1239  24      services  married secondary      no     620     yes   no   unknown   8   may 2008
## 1240   1240  41    technician  married   unknown      no     254     yes   no   unknown   8   may 2008
## 1241   1241  34   blue-collar   single   primary      no       0     yes   no   unknown   8   may 2008
## 1242   1242  29   blue-collar  married secondary      no    5903     yes   no   unknown   8   may 2008
## 1243   1243  42   blue-collar   single   primary      no     134     yes  yes   unknown   8   may 2008
## 1244   1244  45      services  married secondary      no    1381     yes   no   unknown   8   may 2008
## 1245   1245  49    management  married secondary      no     104     yes   no   unknown   8   may 2008
## 1246   1246  26   blue-collar   single   primary      no     318     yes   no   unknown   8   may 2008
## 1247   1247  35    technician   single secondary      no    2151     yes   no   unknown   8   may 2008
## 1248   1248  49      services  married secondary      no      -8     yes   no   unknown   8   may 2008
## 1249   1249  44   blue-collar  married   primary      no     185     yes   no   unknown   8   may 2008
## 1250   1250  41    management  married  tertiary      no    1773      no   no   unknown   8   may 2008
## 1251   1251  50   blue-collar  married   primary      no      40     yes   no   unknown   8   may 2008
## 1252   1252  58       retired  married  tertiary      no      44     yes   no   unknown   8   may 2008
## 1253   1253  43   blue-collar  married secondary      no       0     yes   no   unknown   8   may 2008
## 1254   1254  34    management  married  tertiary      no       0     yes   no   unknown   8   may 2008
## 1255   1255  57        admin. divorced secondary      no    3058     yes   no   unknown   8   may 2008
## 1256   1256  43      services divorced secondary      no     130     yes   no   unknown   8   may 2008
## 1257   1257  38      services  married secondary      no     507     yes   no   unknown   8   may 2008
## 1258   1258  35 self-employed  married  tertiary      no     844     yes   no   unknown   8   may 2008
## 1259   1259  49        admin.  married   primary      no     458     yes   no   unknown   8   may 2008
## 1260   1260  33   blue-collar  married   primary     yes    -744     yes   no   unknown   8   may 2008
## 1261   1261  60       retired  married   primary      no      -2     yes   no   unknown   8   may 2008
## 1262   1262  33    technician   single  tertiary      no     129     yes   no   unknown   8   may 2008
## 1263   1263  33      services divorced secondary      no     411     yes   no   unknown   8   may 2008
## 1264   1264  47    management  married  tertiary      no     643     yes   no   unknown   8   may 2008
## 1265   1265  37    technician   single   unknown      no     391     yes   no   unknown   8   may 2008
## 1266   1266  34   blue-collar  married secondary      no      80     yes  yes   unknown   8   may 2008
## 1267   1267  32    technician   single secondary      no      10     yes   no   unknown   8   may 2008
## 1268   1268  36        admin.  married secondary      no     114     yes  yes   unknown   8   may 2008
## 1269   1269  40   blue-collar   single secondary      no       1     yes   no   unknown   8   may 2008
## 1270   1270  57    management  married  tertiary      no    1341     yes   no   unknown   8   may 2008
## 1271   1271  48   blue-collar  married   primary      no       4     yes   no   unknown   8   may 2008
## 1272   1272  26   blue-collar  married secondary      no    2770     yes   no   unknown   8   may 2008
## 1273   1273  30    management   single  tertiary      no    5956     yes   no   unknown   8   may 2008
## 1274   1274  41        admin.  married secondary      no      55     yes   no   unknown   8   may 2008
## 1275   1275  30 self-employed  married secondary      no     131     yes   no   unknown   8   may 2008
## 1276   1276  35    management  married  tertiary      no    1942     yes   no   unknown   8   may 2008
## 1277   1277  36  entrepreneur  married   unknown      no     298     yes   no   unknown   8   may 2008
## 1278   1278  52    technician  married secondary      no     291      no   no   unknown   8   may 2008
## 1279   1279  45   blue-collar  married   primary      no      85     yes   no   unknown   8   may 2008
## 1280   1280  35    management   single  tertiary      no     797     yes   no   unknown   8   may 2008
## 1281   1281  46   blue-collar   single secondary      no     152     yes   no   unknown   8   may 2008
## 1282   1282  39   blue-collar  married   primary      no     481     yes   no   unknown   8   may 2008
## 1283   1283  38    management  married  tertiary      no      66     yes   no   unknown   8   may 2008
## 1284   1284  38   blue-collar  married secondary      no    4586     yes   no   unknown   8   may 2008
## 1285   1285  31    technician   single  tertiary      no    1798     yes   no   unknown   8   may 2008
## 1286   1286  39    management   single  tertiary      no     220     yes   no   unknown   8   may 2008
## 1287   1287  32   blue-collar  married secondary      no     715     yes   no   unknown   8   may 2008
## 1288   1288  32      services  married secondary      no     442     yes   no   unknown   8   may 2008
## 1289   1289  26       student   single secondary      no      85     yes   no   unknown   8   may 2008
## 1290   1290  35    technician  married secondary      no     319     yes   no   unknown   8   may 2008
## 1291   1291  26   blue-collar   single secondary      no     -29     yes   no   unknown   8   may 2008
## 1292   1292  33        admin.   single secondary      no     303      no   no   unknown   8   may 2008
## 1293   1293  41       unknown   single   primary      no    2398     yes   no   unknown   8   may 2008
## 1294   1294  30  entrepreneur  married secondary      no      31      no   no   unknown   8   may 2008
## 1295   1295  36    technician   single secondary      no    1832     yes   no   unknown   8   may 2008
## 1296   1296  46      services  married secondary      no    2019     yes   no   unknown   8   may 2008
## 1297   1297  30   blue-collar  married   primary      no       3     yes   no   unknown   8   may 2008
## 1298   1298  46      services  married secondary      no     397      no   no   unknown   8   may 2008
## 1299   1299  38    technician  married  tertiary      no    1161     yes   no   unknown   8   may 2008
## 1300   1300  24    technician   single  tertiary      no     777     yes   no   unknown   8   may 2008
## 1301   1301  41    management divorced  tertiary      no      47     yes   no   unknown   8   may 2008
## 1302   1302  28    technician  married   primary      no     -58     yes   no   unknown   8   may 2008
## 1303   1303  55    unemployed   single  tertiary      no    1513     yes   no   unknown   8   may 2008
## 1304   1304  40    management  married  tertiary      no     121      no   no   unknown   8   may 2008
## 1305   1305  38    management divorced  tertiary      no     904     yes   no   unknown   8   may 2008
## 1306   1306  40    technician  married secondary      no     697     yes   no   unknown   8   may 2008
## 1307   1307  54      services  married secondary      no     841     yes   no   unknown   8   may 2008
## 1308   1308  49     housemaid  married secondary      no    7317     yes   no   unknown   8   may 2008
## 1309   1309  44   blue-collar  married secondary      no     -95     yes   no   unknown   8   may 2008
## 1310   1310  32    management   single  tertiary      no     751     yes   no   unknown   8   may 2008
## 1311   1311  36   blue-collar  married   primary      no     250     yes   no   unknown   8   may 2008
## 1312   1312  35    technician   single secondary      no     365     yes   no   unknown   8   may 2008
## 1313   1313  31    management   single  tertiary      no    1315     yes   no   unknown   8   may 2008
## 1314   1314  34    technician  married secondary      no      65     yes   no   unknown   8   may 2008
## 1315   1315  36    management  married  tertiary      no    1852      no   no   unknown   8   may 2008
## 1316   1316  44        admin.   single secondary      no     -84     yes   no   unknown   8   may 2008
## 1317   1317  44   blue-collar   single secondary      no      36     yes   no   unknown   8   may 2008
## 1318   1318  51   blue-collar  married   unknown      no     125     yes   no   unknown   8   may 2008
## 1319   1319  36   blue-collar  married secondary      no       0      no   no   unknown   8   may 2008
## 1320   1320  37   blue-collar  married secondary      no     105     yes   no   unknown   8   may 2008
## 1321   1321  31      services  married secondary      no     432     yes   no   unknown   8   may 2008
## 1322   1322  42   blue-collar  married   primary      no     555     yes   no   unknown   8   may 2008
## 1323   1323  55  entrepreneur  married   primary      no     -24     yes   no   unknown   8   may 2008
## 1324   1324  57    management  married  tertiary      no    2261     yes   no   unknown   8   may 2008
## 1325   1325  33      services  married secondary      no     804     yes  yes   unknown   8   may 2008
## 1326   1326  44   blue-collar  married secondary     yes    -617     yes   no   unknown   8   may 2008
## 1327   1327  30    technician  married secondary      no      -1     yes   no   unknown   8   may 2008
## 1328   1328  37      services  married secondary      no     237     yes   no   unknown   8   may 2008
## 1329   1329  32        admin.  married secondary      no     514     yes   no   unknown   8   may 2008
## 1330   1330  33   blue-collar  married secondary      no    1988     yes   no   unknown   8   may 2008
## 1331   1331  31    technician   single  tertiary      no     491     yes   no   unknown   8   may 2008
## 1332   1332  46    technician  married  tertiary      no     675     yes   no   unknown   8   may 2008
## 1333   1333  34   blue-collar   single secondary      no     177     yes   no   unknown   8   may 2008
## 1334   1334  51        admin. divorced secondary      no     340     yes   no   unknown   8   may 2008
## 1335   1335  49    technician  married   primary      no     230     yes   no   unknown   8   may 2008
## 1336   1336  52    management   single  tertiary     yes       0      no   no   unknown   8   may 2008
## 1337   1337  43    technician  married  tertiary      no    2331     yes   no   unknown   8   may 2008
## 1338   1338  35   blue-collar divorced secondary      no       0     yes   no   unknown   8   may 2008
## 1339   1339  27       student   single secondary      no     217     yes   no   unknown   8   may 2008
## 1340   1340  43   blue-collar  married   primary      no     186     yes   no   unknown   8   may 2008
## 1341   1341  49        admin. divorced secondary      no     168     yes  yes   unknown   8   may 2008
## 1342   1342  50      services divorced secondary      no     145     yes   no   unknown   8   may 2008
## 1343   1343  33        admin. divorced secondary      no     140     yes   no   unknown   8   may 2008
## 1344   1344  49      services  married secondary      no     -22     yes   no   unknown   8   may 2008
## 1345   1345  50    technician  married secondary      no     389     yes   no   unknown   8   may 2008
## 1346   1346  42        admin.  married secondary      no     323     yes  yes   unknown   8   may 2008
## 1347   1347  28      services  married secondary      no       6     yes   no   unknown   8   may 2008
## 1348   1348  41    technician  married secondary      no     225     yes  yes   unknown   8   may 2008
## 1349   1349  34      services  married secondary      no     142     yes   no   unknown   8   may 2008
## 1350   1350  58   blue-collar  married   primary      no       5      no   no   unknown   8   may 2008
## 1351   1351  46   blue-collar  married   primary      no     174     yes  yes   unknown   8   may 2008
## 1352   1352  46   blue-collar  married   primary      no    -768     yes   no   unknown   8   may 2008
## 1353   1353  42   blue-collar  married secondary      no      30      no   no   unknown   8   may 2008
## 1354   1354  40   blue-collar  married   primary      no     968     yes  yes   unknown   8   may 2008
## 1355   1355  42   blue-collar divorced secondary      no      47     yes  yes   unknown   8   may 2008
## 1356   1356  33  entrepreneur  married secondary      no       0     yes  yes   unknown   8   may 2008
## 1357   1357  27      services  married   primary      no      91     yes   no   unknown   8   may 2008
## 1358   1358  43   blue-collar  married   primary      no     -77     yes   no   unknown   8   may 2008
## 1359   1359  28   blue-collar  married   unknown      no     486     yes   no   unknown   8   may 2008
## 1360   1360  34   blue-collar   single secondary      no     341     yes   no   unknown   8   may 2008
## 1361   1361  37      services  married secondary      no      50     yes   no   unknown   8   may 2008
## 1362   1362  41      services  married secondary      no     205     yes   no   unknown   8   may 2008
## 1363   1363  39        admin.   single secondary      no     762     yes   no   unknown   8   may 2008
## 1364   1364  37    technician   single  tertiary      no      31     yes   no   unknown   8   may 2008
## 1365   1365  41    unemployed  married   primary     yes    -581     yes   no   unknown   8   may 2008
## 1366   1366  36      services   single secondary      no     -45     yes   no   unknown   8   may 2008
## 1367   1367  51   blue-collar  married   primary      no       0      no   no   unknown   8   may 2008
## 1368   1368  28 self-employed  married  tertiary      no     120     yes  yes   unknown   8   may 2008
## 1369   1369  31   blue-collar  married secondary      no     335     yes   no   unknown   8   may 2008
## 1370   1370  33      services  married secondary      no    -232     yes   no   unknown   8   may 2008
## 1371   1371  28        admin. divorced secondary      no     785     yes   no   unknown   8   may 2008
## 1372   1372  31      services  married secondary      no      28     yes   no   unknown   8   may 2008
## 1373   1373  43    management   single  tertiary      no    2067     yes   no   unknown   8   may 2008
## 1374   1374  48   blue-collar  married   primary      no     448     yes   no   unknown   8   may 2008
## 1375   1375  26       student   single  tertiary      no      37     yes   no   unknown   8   may 2008
## 1376   1376  34    technician   single  tertiary      no     301     yes   no   unknown   8   may 2008
## 1377   1377  38   blue-collar  married   primary      no     668      no   no   unknown   8   may 2008
## 1378   1378  51        admin. divorced secondary      no     115     yes  yes   unknown   8   may 2008
## 1379   1379  49        admin.   single secondary      no     275      no   no   unknown   8   may 2008
## 1380   1380  60       retired  married   primary      no     414      no   no   unknown   8   may 2008
## 1381   1381  32    management   single  tertiary      no       3     yes   no   unknown   8   may 2008
## 1382   1382  36        admin. divorced secondary      no     496      no   no   unknown   8   may 2008
## 1383   1383  28    management   single  tertiary      no     150     yes   no   unknown   8   may 2008
## 1384   1384  34    management   single  tertiary      no     163      no   no   unknown   8   may 2008
## 1385   1385  40        admin.   single secondary      no    1322     yes   no   unknown   8   may 2008
## 1386   1386  33     housemaid  married   primary      no    1713     yes   no   unknown   8   may 2008
## 1387   1387  37        admin.  married   primary      no     242     yes   no   unknown   8   may 2008
## 1388   1388  40    management  married  tertiary      no     -29      no   no   unknown   8   may 2008
## 1389   1389  59       retired divorced  tertiary      no     381     yes   no   unknown   8   may 2008
## 1390   1390  39   blue-collar   single secondary      no      82     yes   no   unknown   8   may 2008
## 1391   1391  28    management   single  tertiary      no      21     yes   no   unknown   8   may 2008
## 1392   1392  30      services  married secondary      no    1801     yes   no   unknown   8   may 2008
## 1393   1393  40   blue-collar  married   primary      no     640     yes  yes   unknown   8   may 2008
## 1394   1394  28   blue-collar  married   primary      no     113     yes   no   unknown   8   may 2008
## 1395   1395  39   blue-collar  married secondary      no    1042     yes   no   unknown   8   may 2008
## 1396   1396  44      services divorced secondary      no     240     yes   no   unknown   8   may 2008
## 1397   1397  39      services   single secondary      no    -244     yes   no   unknown   8   may 2008
## 1398   1398  30   blue-collar  married   primary      no      70     yes  yes   unknown   8   may 2008
## 1399   1399  35   blue-collar  married secondary      no    -339     yes   no   unknown   8   may 2008
## 1400   1400  31    management  married  tertiary      no      59     yes   no   unknown   8   may 2008
## 1401   1401  47    management  married   primary      no    1222     yes   no   unknown   8   may 2008
## 1402   1402  26       student   single   unknown      no     -41     yes   no   unknown   8   may 2008
## 1403   1403  25   blue-collar   single secondary      no       0     yes   no   unknown   8   may 2008
## 1404   1404  42    management  married  tertiary      no       6     yes   no   unknown   8   may 2008
## 1405   1405  30   blue-collar  married   primary      no       4     yes   no   unknown   8   may 2008
## 1406   1406  28      services  married secondary      no      20     yes  yes   unknown   8   may 2008
## 1407   1407  46        admin. divorced  tertiary      no     846     yes   no   unknown   8   may 2008
## 1408   1408  43   blue-collar divorced secondary      no     338     yes   no   unknown   8   may 2008
## 1409   1409  38    technician  married   unknown      no      90     yes  yes   unknown   8   may 2008
## 1410   1410  31   blue-collar  married   primary      no     406     yes   no   unknown   8   may 2008
## 1411   1411  29      services   single secondary      no       2      no   no   unknown   8   may 2008
## 1412   1412  34      services  married secondary      no    2211      no   no   unknown   8   may 2008
## 1413   1413  40   blue-collar  married   primary      no      87     yes   no   unknown   8   may 2008
## 1414   1414  30    technician   single  tertiary      no     178     yes   no   unknown   8   may 2008
## 1415   1415  44    technician  married   unknown      no     185     yes  yes   unknown   8   may 2008
## 1416   1416  38   blue-collar  married secondary      no    -210     yes   no   unknown   8   may 2008
## 1417   1417  43    management divorced  tertiary      no     388     yes   no   unknown   8   may 2008
## 1418   1418  32   blue-collar  married secondary      no       1     yes   no   unknown   8   may 2008
## 1419   1419  33    management  married secondary     yes     879     yes   no   unknown   8   may 2008
## 1420   1420  32   blue-collar  married secondary      no     214     yes   no   unknown   8   may 2008
## 1421   1421  40    technician  married   unknown      no     698     yes   no   unknown   8   may 2008
## 1422   1422  34    management  married  tertiary      no    1601     yes   no   unknown   8   may 2008
## 1423   1423  30   blue-collar  married secondary      no     717     yes   no   unknown   8   may 2008
## 1424   1424  53   blue-collar divorced   primary      no     255     yes   no   unknown   8   may 2008
## 1425   1425  39    management   single  tertiary      no     375     yes   no   unknown   8   may 2008
## 1426   1426  46   blue-collar  married   primary      no     587     yes   no   unknown   8   may 2008
## 1427   1427  32    management  married  tertiary      no     644     yes  yes   unknown   8   may 2008
## 1428   1428  60    technician  married   unknown      no       0     yes   no   unknown   8   may 2008
## 1429   1429  40    management   single  tertiary      no    -275     yes   no   unknown   8   may 2008
## 1430   1430  47   blue-collar  married secondary      no     116     yes   no   unknown   8   may 2008
## 1431   1431  25  entrepreneur  married  tertiary      no      37     yes  yes   unknown   8   may 2008
## 1432   1432  44   blue-collar  married   primary      no     753     yes   no   unknown   8   may 2008
## 1433   1433  38   blue-collar   single   primary      no     162     yes   no   unknown   8   may 2008
## 1434   1434  45        admin. divorced secondary      no     984     yes   no   unknown   8   may 2008
## 1435   1435  34   blue-collar  married secondary      no     199     yes   no   unknown   8   may 2008
## 1436   1436  36      services divorced secondary      no     241     yes   no   unknown   8   may 2008
## 1437   1437  30   blue-collar   single secondary      no     648     yes  yes   unknown   8   may 2008
## 1438   1438  35   blue-collar   single secondary      no     907     yes  yes   unknown   8   may 2008
## 1439   1439  39    unemployed divorced secondary      no    6322      no   no   unknown   8   may 2008
## 1440   1440  46   blue-collar  married secondary      no     125     yes  yes   unknown   8   may 2008
## 1441   1441  36 self-employed  married   primary      no      90     yes   no   unknown   8   may 2008
## 1442   1442  22    technician   single secondary      no      54     yes  yes   unknown   8   may 2008
## 1443   1443  26   blue-collar   single secondary      no    -132      no   no   unknown   8   may 2008
## 1444   1444  48        admin. divorced secondary      no     267      no   no   unknown   8   may 2008
## 1445   1445  32   blue-collar  married   primary      no     289     yes   no   unknown   8   may 2008
## 1446   1446  58 self-employed divorced secondary      no     613     yes   no   unknown   8   may 2008
## 1447   1447  57  entrepreneur  married   unknown      no     618     yes   no   unknown   8   may 2008
## 1448   1448  53    management  married  tertiary      no    1786     yes   no   unknown   8   may 2008
## 1449   1449  29    management divorced  tertiary      no     607     yes  yes   unknown   8   may 2008
## 1450   1450  34      services  married secondary      no     586     yes  yes   unknown   8   may 2008
## 1451   1451  32      services   single secondary      no     459     yes   no   unknown   8   may 2008
## 1452   1452  55  entrepreneur  married   primary      no     298     yes   no   unknown   8   may 2008
## 1453   1453  50   blue-collar divorced   primary      no     134      no   no   unknown   8   may 2008
## 1454   1454  43   blue-collar  married   primary      no      34     yes   no   unknown   8   may 2008
## 1455   1455  44      services   single secondary      no    1378     yes   no   unknown   8   may 2008
## 1456   1456  27   blue-collar  married  tertiary      no     417     yes  yes   unknown   8   may 2008
## 1457   1457  35   blue-collar  married secondary      no      25     yes   no   unknown   8   may 2008
## 1458   1458  45      services  married secondary      no      22     yes   no   unknown   8   may 2008
## 1459   1459  35   blue-collar   single   primary      no     398     yes   no   unknown   8   may 2008
## 1460   1460  49   blue-collar   single   primary      no    1164     yes   no   unknown   8   may 2008
## 1461   1461  34    management  married secondary      no     487     yes   no   unknown   8   may 2008
## 1462   1462  46        admin.  married secondary      no    1069     yes   no   unknown   8   may 2008
## 1463   1463  43   blue-collar  married   primary      no    -192     yes   no   unknown   8   may 2008
## 1464   1464  42       retired  married   primary      no       0     yes   no   unknown   8   may 2008
## 1465   1465  55   blue-collar  married   primary      no     332     yes   no   unknown   8   may 2008
## 1466   1466  37   blue-collar  married secondary      no     121     yes   no   unknown   8   may 2008
## 1467   1467  31   blue-collar  married   primary      no      68     yes   no   unknown   8   may 2008
## 1468   1468  57   blue-collar divorced   primary      no    -176     yes   no   unknown   8   may 2008
## 1469   1469  33   blue-collar  married secondary      no     527     yes  yes   unknown   8   may 2008
## 1470   1470  43      services   single   unknown      no     193     yes   no   unknown   8   may 2008
## 1471   1471  60   blue-collar divorced   primary      no    7601     yes   no   unknown   8   may 2008
## 1472   1472  51    management  married  tertiary      no     751      no   no   unknown   8   may 2008
## 1473   1473  38   blue-collar   single   unknown      no     495     yes   no   unknown   8   may 2008
## 1474   1474  37    technician   single secondary      no     670     yes   no   unknown   8   may 2008
## 1475   1475  41   blue-collar   single secondary      no     363     yes   no   unknown   8   may 2008
## 1476   1476  42   blue-collar  married secondary      no     376     yes   no   unknown   8   may 2008
## 1477   1477  41    management divorced  tertiary      no     292     yes   no   unknown   8   may 2008
## 1478   1478  33    technician  married   unknown      no       0      no   no   unknown   8   may 2008
## 1479   1479  32        admin.   single secondary      no     184     yes   no   unknown   8   may 2008
## 1480   1480  30      services  married secondary      no      80     yes   no   unknown   8   may 2008
## 1481   1481  43    technician  married secondary      no    1824     yes   no   unknown   8   may 2008
## 1482   1482  30   blue-collar  married secondary      no    2850      no   no   unknown   8   may 2008
## 1483   1483  37   blue-collar divorced secondary      no      48     yes   no   unknown   8   may 2008
## 1484   1484  34    management  married  tertiary      no      76      no   no   unknown   8   may 2008
## 1485   1485  32    unemployed   single  tertiary      no     336     yes   no   unknown   8   may 2008
## 1486   1486  42    technician  married secondary      no       0      no  yes   unknown   8   may 2008
## 1487   1487  35    technician   single secondary      no     433     yes   no   unknown   8   may 2008
## 1488   1488  34   blue-collar  married secondary      no     103     yes  yes   unknown   8   may 2008
## 1489   1489  50   blue-collar  married   primary      no    1164     yes   no   unknown   8   may 2008
## 1490   1490  34   blue-collar  married secondary      no     129     yes   no   unknown   8   may 2008
## 1491   1491  38      services divorced secondary      no    5873      no   no   unknown   8   may 2008
## 1492   1492  28   blue-collar  married secondary      no       0     yes   no   unknown   8   may 2008
## 1493   1493  55   blue-collar  married   primary      no      82     yes   no   unknown   8   may 2008
## 1494   1494  38   blue-collar  married   primary      no     362     yes   no   unknown   8   may 2008
## 1495   1495  31   blue-collar  married secondary      no     186     yes   no   unknown   8   may 2008
## 1496   1496  57        admin.  married secondary      no    1216     yes   no   unknown   8   may 2008
## 1497   1497  50    management divorced  tertiary      no     704     yes   no   unknown   8   may 2008
## 1498   1498  47   blue-collar  married   primary      no     205     yes   no   unknown   8   may 2008
## 1499   1499  39   blue-collar  married   primary      no     830     yes   no   unknown   8   may 2008
## 1500   1500  34      services  married secondary      no    -315     yes   no   unknown   8   may 2008
## 1501   1501  41    technician  married secondary      no      64     yes  yes   unknown   8   may 2008
## 1502   1502  59  entrepreneur  married  tertiary      no    -820      no   no   unknown   8   may 2008
## 1503   1503  35 self-employed   single  tertiary      no     538     yes  yes   unknown   8   may 2008
## 1504   1504  31    technician   single  tertiary      no     948     yes   no   unknown   8   may 2008
## 1505   1505  55    management  married  tertiary      no    1288     yes   no   unknown   8   may 2008
## 1506   1506  36   blue-collar  married   unknown      no      70     yes   no   unknown   8   may 2008
## 1507   1507  41    management  married  tertiary      no     393     yes   no   unknown   8   may 2008
## 1508   1508  44    technician   single secondary      no     365     yes   no   unknown   8   may 2008
## 1509   1509  40   blue-collar   single secondary      no     879     yes  yes   unknown   8   may 2008
## 1510   1510  32   blue-collar  married secondary      no     491     yes   no   unknown   8   may 2008
## 1511   1511  38    management   single  tertiary      no       0     yes   no   unknown   8   may 2008
## 1512   1512  27       student   single secondary      no       0      no   no   unknown   8   may 2008
## 1513   1513  33    unemployed  married secondary      no     229     yes   no   unknown   8   may 2008
## 1514   1514  37      services  married secondary      no      22     yes  yes   unknown   8   may 2008
## 1515   1515  40    management  married  tertiary      no     570     yes   no   unknown   8   may 2008
## 1516   1516  33   blue-collar   single secondary      no      56     yes   no   unknown   8   may 2008
## 1517   1517  40        admin.   single secondary      no     118     yes   no   unknown   8   may 2008
## 1518   1518  27   blue-collar  married secondary      no     106     yes   no   unknown   8   may 2008
## 1519   1519  42    management   single  tertiary      no    1768     yes   no   unknown   8   may 2008
## 1520   1520  41   blue-collar  married secondary      no     213     yes   no   unknown   8   may 2008
## 1521   1521  37    unemployed   single secondary      no     381     yes   no   unknown   8   may 2008
## 1522   1522  38    unemployed  married   primary      no    1147     yes  yes   unknown   8   may 2008
## 1523   1523  44   blue-collar  married secondary      no     373     yes   no   unknown   8   may 2008
## 1524   1524  31   blue-collar  married   primary      no      50     yes   no   unknown   8   may 2008
## 1525   1525  34   blue-collar  married secondary      no      67     yes  yes   unknown   8   may 2008
## 1526   1526  46   blue-collar  married   primary      no       0     yes  yes   unknown   8   may 2008
## 1527   1527  33        admin.  married secondary      no      61     yes  yes   unknown   8   may 2008
## 1528   1528  36   blue-collar  married secondary      no     504     yes   no   unknown   8   may 2008
## 1529   1529  32    unemployed   single secondary      no     177     yes   no   unknown   8   may 2008
## 1530   1530  27    technician   single secondary      no     584     yes   no   unknown   8   may 2008
## 1531   1531  31      services  married   primary      no    -732     yes   no   unknown   8   may 2008
## 1532   1532  41    management   single  tertiary      no     572     yes   no   unknown   8   may 2008
## 1533   1533  35   blue-collar  married   primary      no     105     yes   no   unknown   8   may 2008
## 1534   1534  50    technician   single  tertiary      no       0     yes   no   unknown   8   may 2008
## 1535   1535  33    technician  married secondary      no     832     yes  yes   unknown   8   may 2008
## 1536   1536  48   blue-collar  married   primary      no    2642     yes   no   unknown   8   may 2008
## 1537   1537  36    technician  married secondary      no     195     yes   no   unknown   8   may 2008
## 1538   1538  29     housemaid   single secondary      no     718     yes   no   unknown   8   may 2008
## 1539   1539  34    management  married  tertiary      no     336     yes  yes   unknown   8   may 2008
## 1540   1540  39   blue-collar  married   primary      no     332     yes   no   unknown   8   may 2008
## 1541   1541  32    management divorced  tertiary      no       1     yes   no   unknown   8   may 2008
## 1542   1542  59       retired divorced   primary      no    -138     yes  yes   unknown   8   may 2008
## 1543   1543  50   blue-collar  married   primary      no     749      no   no   unknown   8   may 2008
## 1544   1544  37        admin.  married secondary      no      14     yes   no   unknown   8   may 2008
## 1545   1545  33    unemployed   single secondary      no     177      no   no   unknown   8   may 2008
## 1546   1546  52   blue-collar  married secondary      no     557      no   no   unknown   8   may 2008
## 1547   1547  43   blue-collar  married   primary      no     126     yes   no   unknown   8   may 2008
## 1548   1548  53   blue-collar  married secondary      no     359      no  yes   unknown   8   may 2008
## 1549   1549  37   blue-collar  married   primary      no     496     yes   no   unknown   8   may 2008
## 1550   1550  50      services   single secondary      no      72      no   no   unknown   8   may 2008
## 1551   1551  53   blue-collar  married secondary      no     175     yes   no   unknown   8   may 2008
## 1552   1552  47   blue-collar  married   primary      no     430      no   no   unknown   8   may 2008
## 1553   1553  48    technician divorced  tertiary      no     574     yes   no   unknown   8   may 2008
## 1554   1554  35    technician divorced secondary      no      69     yes   no   unknown   8   may 2008
## 1555   1555  42 self-employed  married secondary      no     106     yes   no   unknown   8   may 2008
## 1556   1556  43    management divorced  tertiary      no       0     yes   no   unknown   8   may 2008
## 1557   1557  40      services   single secondary      no      23     yes   no   unknown   8   may 2008
## 1558   1558  36      services  married secondary      no      42     yes   no   unknown   8   may 2008
## 1559   1559  39    management  married  tertiary      no     429     yes   no   unknown   8   may 2008
## 1560   1560  32   blue-collar divorced   primary      no      88     yes   no   unknown   8   may 2008
## 1561   1561  44    management divorced  tertiary      no    3932     yes   no   unknown   8   may 2008
## 1562   1562  43    technician divorced secondary      no     177     yes   no   unknown   8   may 2008
## 1563   1563  53 self-employed  married secondary      no     468     yes   no   unknown   8   may 2008
## 1564   1564  41      services  married secondary      no     639     yes   no   unknown   8   may 2008
## 1565   1565  53    management  married  tertiary      no    2124     yes   no   unknown   8   may 2008
## 1566   1566  31    unemployed  married   primary      no     309     yes   no   unknown   8   may 2008
## 1567   1567  51   blue-collar  married   primary      no     202     yes   no   unknown   8   may 2008
## 1568   1568  32   blue-collar  married secondary      no      20     yes  yes   unknown   8   may 2008
## 1569   1569  52   blue-collar  married secondary      no     -17     yes   no   unknown   8   may 2008
## 1570   1570  41    management  married   primary      no    -417     yes   no   unknown   8   may 2008
## 1571   1571  30    management   single  tertiary      no     528     yes   no   unknown   8   may 2008
## 1572   1572  32    management   single  tertiary      no     394     yes   no   unknown   8   may 2008
## 1573   1573  31   blue-collar  married   primary      no     856     yes   no   unknown   8   may 2008
## 1574   1574  38   blue-collar  married secondary      no     468     yes   no   unknown   8   may 2008
## 1575   1575  44   blue-collar  married secondary      no     138     yes   no   unknown   8   may 2008
## 1576   1576  36   blue-collar  married secondary      no     406     yes   no   unknown   8   may 2008
## 1577   1577  34        admin.  married  tertiary      no     221     yes   no   unknown   8   may 2008
## 1578   1578  40        admin.  married secondary      no     523     yes  yes   unknown   8   may 2008
## 1579   1579  41   blue-collar  married   primary      no     -52     yes   no   unknown   8   may 2008
## 1580   1580  56    technician divorced secondary      no     397     yes   no   unknown   8   may 2008
## 1581   1581  39   blue-collar  married   primary      no    -432     yes   no   unknown   8   may 2008
## 1582   1582  34   blue-collar  married   primary      no     298     yes   no   unknown   8   may 2008
## 1583   1583  41   blue-collar   single secondary      no    1080     yes  yes   unknown   8   may 2008
## 1584   1584  39    management   single  tertiary      no     -85     yes   no   unknown   8   may 2008
## 1585   1585  33        admin.  married secondary      no    4012      no  yes   unknown   8   may 2008
## 1586   1586  52    management divorced secondary      no     123      no   no   unknown   8   may 2008
## 1587   1587  26    management   single  tertiary      no     498     yes   no   unknown   8   may 2008
## 1588   1588  54    unemployed  married secondary      no      23     yes   no   unknown   8   may 2008
## 1589   1589  30    technician  married   unknown     yes    -315     yes   no   unknown   8   may 2008
## 1590   1590  35    management  married  tertiary     yes      89      no  yes   unknown   8   may 2008
## 1591   1591  47    technician divorced secondary      no     699     yes   no   unknown   8   may 2008
## 1592   1592  53   blue-collar divorced secondary      no     145     yes   no   unknown   8   may 2008
## 1593   1593  29   blue-collar   single secondary      no    -138     yes  yes   unknown   8   may 2008
## 1594   1594  36    technician  married  tertiary      no     491     yes   no   unknown   8   may 2008
## 1595   1595  35    management  married  tertiary      no     820     yes   no   unknown   8   may 2008
## 1596   1596  43   blue-collar  married secondary      no    1376     yes   no   unknown   8   may 2008
## 1597   1597  38   blue-collar  married   primary      no       0     yes   no   unknown   8   may 2008
## 1598   1598  39   blue-collar  married secondary      no     507     yes   no   unknown   8   may 2008
## 1599   1599  58    management  married secondary      no     771      no   no   unknown   8   may 2008
## 1600   1600  33      services  married secondary      no     310     yes   no   unknown   8   may 2008
## 1601   1601  60   blue-collar  married   primary      no     136     yes   no   unknown   8   may 2008
## 1602   1602  45        admin.  married secondary      no     310     yes   no   unknown   8   may 2008
## 1603   1603  39   blue-collar  married   primary      no     813     yes   no   unknown   8   may 2008
## 1604   1604  35    management  married  tertiary      no      14     yes  yes   unknown   8   may 2008
## 1605   1605  41   blue-collar  married   primary      no     -97     yes   no   unknown   8   may 2008
## 1606   1606  40      services  married   primary      no     332     yes   no   unknown   8   may 2008
## 1607   1607  33      services  married secondary      no    5034     yes   no   unknown   8   may 2008
## 1608   1608  32        admin. divorced secondary      no     281     yes   no   unknown   8   may 2008
## 1609   1609  44    management  married secondary      no     576     yes   no   unknown   8   may 2008
## 1610   1610  34    management   single  tertiary      no    1891     yes   no   unknown   9   may 2008
## 1611   1611  29      services   single secondary      no     473     yes  yes   unknown   9   may 2008
## 1612   1612  49   blue-collar  married   primary      no     216     yes   no   unknown   9   may 2008
## 1613   1613  31   blue-collar  married secondary      no     -13     yes   no   unknown   9   may 2008
## 1614   1614  47        admin. divorced secondary      no     162     yes   no   unknown   9   may 2008
## 1615   1615  34   blue-collar  married   primary      no     365     yes   no   unknown   9   may 2008
## 1616   1616  32    management   single  tertiary      no     264     yes   no   unknown   9   may 2008
## 1617   1617  32        admin.   single  tertiary      no     490     yes   no   unknown   9   may 2008
## 1618   1618  56    technician   single   primary      no     230     yes   no   unknown   9   may 2008
## 1619   1619  28    technician   single secondary      no      -9     yes  yes   unknown   9   may 2008
## 1620   1620  35    technician   single secondary      no     317     yes   no   unknown   9   may 2008
## 1621   1621  52 self-employed   single  tertiary      no     458     yes  yes   unknown   9   may 2008
## 1622   1622  35    technician  married secondary      no      19     yes   no   unknown   9   may 2008
## 1623   1623  32   blue-collar  married secondary      no     536     yes   no   unknown   9   may 2008
## 1624   1624  42    management divorced secondary      no     117     yes   no   unknown   9   may 2008
## 1625   1625  51   blue-collar   single   primary      no     368     yes   no   unknown   9   may 2008
## 1626   1626  47   blue-collar  married secondary      no     -98     yes   no   unknown   9   may 2008
## 1627   1627  34      services  married secondary      no     627     yes   no   unknown   9   may 2008
## 1628   1628  45        admin.  married secondary      no     180     yes   no   unknown   9   may 2008
## 1629   1629  31    technician divorced secondary      no      26     yes   no   unknown   9   may 2008
## 1630   1630  40   blue-collar  married   primary      no    2171     yes   no   unknown   9   may 2008
## 1631   1631  53  entrepreneur  married secondary      no    -118     yes   no   unknown   9   may 2008
## 1632   1632  44    technician   single secondary      no    1059     yes   no   unknown   9   may 2008
## 1633   1633  49   blue-collar  married   primary      no     186     yes   no   unknown   9   may 2008
## 1634   1634  47      services  married secondary      no    1306     yes   no   unknown   9   may 2008
## 1635   1635  31   blue-collar  married   primary      no    3007     yes   no   unknown   9   may 2008
## 1636   1636  45        admin.   single secondary      no     -88     yes   no   unknown   9   may 2008
## 1637   1637  30   blue-collar  married   primary      no     265     yes  yes   unknown   9   may 2008
## 1638   1638  40   blue-collar divorced   primary      no      21     yes   no   unknown   9   may 2008
## 1639   1639  27        admin.   single   unknown      no     230     yes   no   unknown   9   may 2008
## 1640   1640  28        admin.  married secondary      no     252     yes   no   unknown   9   may 2008
## 1641   1641  28        admin.   single  tertiary      no     422     yes   no   unknown   9   may 2008
## 1642   1642  44   blue-collar  married secondary      no      85     yes   no   unknown   9   may 2008
## 1643   1643  35    management  married  tertiary      no    4286     yes   no   unknown   9   may 2008
## 1644   1644  29   blue-collar  married secondary      no       0      no   no   unknown   9   may 2008
## 1645   1645  33   blue-collar divorced   primary      no      60      no   no   unknown   9   may 2008
## 1646   1646  32   blue-collar  married secondary      no     687     yes   no   unknown   9   may 2008
## 1647   1647  35   blue-collar   single secondary      no      40     yes   no   unknown   9   may 2008
## 1648   1648  31    technician   single  tertiary      no      22     yes   no   unknown   9   may 2008
## 1649   1649  36    technician   single secondary      no    -333     yes  yes   unknown   9   may 2008
## 1650   1650  41    technician  married secondary      no     483     yes   no   unknown   9   may 2008
## 1651   1651  35   blue-collar  married secondary      no     503     yes  yes   unknown   9   may 2008
## 1652   1652  40   blue-collar  married secondary      no    1245     yes   no   unknown   9   may 2008
## 1653   1653  42   blue-collar  married secondary      no     117     yes   no   unknown   9   may 2008
## 1654   1654  34    technician   single  tertiary     yes      33     yes  yes   unknown   9   may 2008
## 1655   1655  41    technician   single secondary      no    -320     yes   no   unknown   9   may 2008
## 1656   1656  43   blue-collar divorced   primary      no      49     yes   no   unknown   9   may 2008
## 1657   1657  37    management  married  tertiary      no       0     yes   no   unknown   9   may 2008
## 1658   1658  26   blue-collar   single secondary      no     100     yes   no   unknown   9   may 2008
## 1659   1659  32     housemaid  married   primary      no     344     yes   no   unknown   9   may 2008
## 1660   1660  51   blue-collar  married secondary      no    -286     yes   no   unknown   9   may 2008
## 1661   1661  38   blue-collar   single secondary      no      57     yes   no   unknown   9   may 2008
## 1662   1662  51    unemployed divorced secondary      no     370      no   no   unknown   9   may 2008
## 1663   1663  49      services divorced secondary      no     470     yes   no   unknown   9   may 2008
## 1664   1664  31     housemaid  married secondary      no       0     yes   no   unknown   9   may 2008
## 1665   1665  33   blue-collar  married   primary      no     767     yes   no   unknown   9   may 2008
## 1666   1666  30        admin.   single   unknown     yes       1      no   no   unknown   9   may 2008
## 1667   1667  33    technician  married secondary      no       0      no   no   unknown   9   may 2008
## 1668   1668  41    unemployed  married secondary      no     121     yes   no   unknown   9   may 2008
## 1669   1669  37   blue-collar  married secondary      no     190     yes   no   unknown   9   may 2008
## 1670   1670  33   blue-collar  married   primary      no     120     yes   no   unknown   9   may 2008
## 1671   1671  32      services  married secondary      no    2068     yes  yes   unknown   9   may 2008
## 1672   1672  46    technician  married secondary      no     332     yes   no   unknown   9   may 2008
## 1673   1673  34    management   single  tertiary      no    -322      no   no   unknown   9   may 2008
## 1674   1674  32   blue-collar  married   primary      no     274     yes   no   unknown   9   may 2008
## 1675   1675  43   blue-collar   single secondary      no       3     yes   no   unknown   9   may 2008
## 1676   1676  28   blue-collar  married secondary      no       6     yes   no   unknown   9   may 2008
## 1677   1677  46    technician divorced  tertiary      no     288     yes   no   unknown   9   may 2008
## 1678   1678  52      services divorced   primary      no     146     yes   no   unknown   9   may 2008
## 1679   1679  34   blue-collar  married secondary      no     286     yes   no   unknown   9   may 2008
## 1680   1680  27    technician divorced secondary      no     114     yes  yes   unknown   9   may 2008
## 1681   1681  32    technician   single  tertiary      no     190     yes  yes   unknown   9   may 2008
## 1682   1682  37   blue-collar   single secondary      no     111     yes   no   unknown   9   may 2008
## 1683   1683  29    management  married  tertiary      no     246     yes   no   unknown   9   may 2008
## 1684   1684  40     housemaid divorced secondary      no     108      no   no   unknown   9   may 2008
## 1685   1685  47    technician  married   primary      no     187     yes   no   unknown   9   may 2008
## 1686   1686  34   blue-collar  married secondary      no     457     yes   no   unknown   9   may 2008
## 1687   1687  25        admin.   single secondary      no     131     yes  yes   unknown   9   may 2008
## 1688   1688  30    management  married  tertiary      no    1825     yes   no   unknown   9   may 2008
## 1689   1689  31        admin.  married secondary      no     307     yes   no   unknown   9   may 2008
## 1690   1690  35   blue-collar  married secondary     yes    -198     yes   no   unknown   9   may 2008
## 1691   1691  32   blue-collar divorced secondary      no     739     yes   no   unknown   9   may 2008
## 1692   1692  28   blue-collar   single secondary      no     759     yes   no   unknown   9   may 2008
## 1693   1693  27      services   single secondary      no     777     yes   no   unknown   9   may 2008
## 1694   1694  37   blue-collar  married   primary      no     378     yes   no   unknown   9   may 2008
## 1695   1695  35   blue-collar   single   primary      no     337     yes   no   unknown   9   may 2008
## 1696   1696  34   blue-collar  married   primary      no     -78     yes   no   unknown   9   may 2008
## 1697   1697  31        admin.  married secondary      no     355     yes   no   unknown   9   may 2008
## 1698   1698  36    management divorced  tertiary      no     133     yes   no   unknown   9   may 2008
## 1699   1699  38    technician  married secondary      no      32     yes   no   unknown   9   may 2008
## 1700   1700  25      services  married secondary      no      55     yes  yes   unknown   9   may 2008
## 1701   1701  51    management   single  tertiary      no     417     yes   no   unknown   9   may 2008
## 1702   1702  26   blue-collar   single secondary      no     153     yes   no   unknown   9   may 2008
## 1703   1703  40       retired  married  tertiary      no     794      no   no   unknown   9   may 2008
## 1704   1704  26      services   single secondary      no     187     yes   no   unknown   9   may 2008
## 1705   1705  36      services  married secondary      no     335     yes   no   unknown   9   may 2008
## 1706   1706  59   blue-collar  married secondary      no    1407     yes   no   unknown   9   may 2008
## 1707   1707  26   blue-collar   single secondary      no    -116     yes  yes   unknown   9   may 2008
## 1708   1708  49 self-employed  married  tertiary      no    1842     yes   no   unknown   9   may 2008
## 1709   1709  33   blue-collar  married   primary      no     329     yes   no   unknown   9   may 2008
## 1710   1710  31   blue-collar  married secondary      no     428     yes   no   unknown   9   may 2008
## 1711   1711  59    management   single secondary      no     181     yes   no   unknown   9   may 2008
## 1712   1712  38  entrepreneur  married secondary      no    2139     yes   no   unknown   9   may 2008
## 1713   1713  37      services   single secondary      no     253     yes  yes   unknown   9   may 2008
## 1714   1714  31    unemployed   single  tertiary      no     133     yes   no   unknown   9   may 2008
## 1715   1715  54       retired  married secondary      no     785     yes   no   unknown   9   may 2008
## 1716   1716  41   blue-collar  married   primary      no     -45     yes  yes   unknown   9   may 2008
## 1717   1717  44    management  married  tertiary      no     223     yes   no   unknown   9   may 2008
## 1718   1718  28        admin.   single secondary      no    2831     yes   no   unknown   9   may 2008
## 1719   1719  22       student   single secondary      no    2412     yes   no   unknown   9   may 2008
## 1720   1720  31   blue-collar  married   primary      no      11     yes   no   unknown   9   may 2008
## 1721   1721  36      services  married secondary      no     211     yes   no   unknown   9   may 2008
## 1722   1722  37        admin. divorced secondary      no      34     yes   no   unknown   9   may 2008
## 1723   1723  54        admin.  married secondary      no     222     yes   no   unknown   9   may 2008
## 1724   1724  28    management   single  tertiary      no    3285     yes   no   unknown   9   may 2008
## 1725   1725  42   blue-collar  married   primary      no     -67     yes   no   unknown   9   may 2008
## 1726   1726  35    technician   single  tertiary      no     670     yes   no   unknown   9   may 2008
## 1727   1727  29        admin.  married secondary      no       0     yes   no   unknown   9   may 2008
## 1728   1728  59   blue-collar   single   primary      no      96     yes   no   unknown   9   may 2008
## 1729   1729  46   blue-collar  married secondary      no      -3     yes   no   unknown   9   may 2008
## 1730   1730  32 self-employed   single secondary      no     123     yes   no   unknown   9   may 2008
## 1731   1731  43    management divorced  tertiary      no     443     yes   no   unknown   9   may 2008
## 1732   1732  41   blue-collar  married   primary      no     406     yes   no   unknown   9   may 2008
## 1733   1733  31        admin.  married secondary      no     535      no   no   unknown   9   may 2008
## 1734   1734  26      services   single secondary      no     302     yes   no   unknown   9   may 2008
## 1735   1735  29   blue-collar  married   primary     yes     -43     yes   no   unknown   9   may 2008
## 1736   1736  31      services  married secondary      no    -346      no   no   unknown   9   may 2008
## 1737   1737  37   blue-collar divorced secondary      no    -271     yes   no   unknown   9   may 2008
## 1738   1738  35    technician  married secondary      no      55     yes   no   unknown   9   may 2008
## 1739   1739  31    technician   single  tertiary      no     375     yes   no   unknown   9   may 2008
## 1740   1740  30   blue-collar  married secondary      no      -2     yes   no   unknown   9   may 2008
## 1741   1741  29   blue-collar   single   primary      no    -680     yes   no   unknown   9   may 2008
## 1742   1742  29        admin. divorced secondary      no       0      no   no   unknown   9   may 2008
## 1743   1743  39   blue-collar   single secondary      no     217     yes   no   unknown   9   may 2008
## 1744   1744  31   blue-collar   single secondary      no     160     yes   no   unknown   9   may 2008
## 1745   1745  27    management   single  tertiary      no     118     yes   no   unknown   9   may 2008
## 1746   1746  22        admin.   single secondary      no      -1     yes   no   unknown   9   may 2008
## 1747   1747  31    management   single secondary      no     453     yes   no   unknown   9   may 2008
## 1748   1748  39   blue-collar   single secondary      no     169     yes   no   unknown   9   may 2008
## 1749   1749  25        admin.   single secondary      no     787     yes   no   unknown   9   may 2008
## 1750   1750  27 self-employed   single secondary      no      78     yes   no   unknown   9   may 2008
## 1751   1751  28    technician   single  tertiary      no    2269     yes   no   unknown   9   may 2008
## 1752   1752  31    unemployed  married   primary      no     213     yes   no   unknown   9   may 2008
## 1753   1753  46    technician divorced secondary      no     164     yes   no   unknown   9   may 2008
## 1754   1754  37   blue-collar  married secondary      no     934      no   no   unknown   9   may 2008
## 1755   1755  27      services   single secondary      no       4     yes  yes   unknown   9   may 2008
## 1756   1756  34    unemployed divorced secondary      no     354     yes   no   unknown   9   may 2008
## 1757   1757  30    technician   single secondary      no      23     yes   no   unknown   9   may 2008
## 1758   1758  23       student   single secondary      no     318     yes   no   unknown   9   may 2008
## 1759   1759  33    technician divorced secondary     yes    -305      no  yes   unknown   9   may 2008
## 1760   1760  43        admin.  married secondary      no     616     yes   no   unknown   9   may 2008
## 1761   1761  50   blue-collar  married   primary      no    2590     yes   no   unknown   9   may 2008
## 1762   1762  31    technician  married secondary      no    1868     yes   no   unknown   9   may 2008
## 1763   1763  32   blue-collar   single secondary      no    -578      no   no   unknown   9   may 2008
## 1764   1764  32        admin.   single secondary      no    -227     yes  yes   unknown   9   may 2008
## 1765   1765  37    technician divorced secondary      no    1981     yes   no   unknown   9   may 2008
## 1766   1766  60    management divorced   unknown      no     404     yes   no   unknown   9   may 2008
## 1767   1767  47   blue-collar divorced secondary      no      65     yes   no   unknown   9   may 2008
## 1768   1768  32   blue-collar  married secondary     yes      -1     yes   no   unknown   9   may 2008
## 1769   1769  34      services  married secondary      no     -68     yes   no   unknown   9   may 2008
## 1770   1770  36   blue-collar divorced   unknown      no       0     yes   no   unknown   9   may 2008
## 1771   1771  28      services   single secondary      no     229     yes   no   unknown   9   may 2008
## 1772   1772  31      services divorced secondary      no    1656     yes   no   unknown   9   may 2008
## 1773   1773  43     housemaid  married   primary      no    1342     yes  yes   unknown   9   may 2008
## 1774   1774  32    unemployed   single secondary      no     331     yes   no   unknown   9   may 2008
## 1775   1775  31      services  married secondary      no     238     yes  yes   unknown   9   may 2008
## 1776   1776  56        admin.  married   primary      no     202     yes   no   unknown   9   may 2008
## 1777   1777  34    management   single  tertiary      no     318     yes   no   unknown   9   may 2008
## 1778   1778  46    technician   single secondary     yes   -1124     yes  yes   unknown   9   may 2008
## 1779   1779  27        admin.   single secondary      no     662     yes   no   unknown   9   may 2008
## 1780   1780  33   blue-collar  married secondary      no    1790     yes  yes   unknown   9   may 2008
## 1781   1781  35   blue-collar  married   primary      no     198     yes   no   unknown   9   may 2008
## 1782   1782  29    management   single  tertiary      no     726     yes   no   unknown   9   may 2008
## 1783   1783  39    management  married  tertiary      no     183     yes   no   unknown   9   may 2008
## 1784   1784  48   blue-collar  married secondary      no     149     yes   no   unknown   9   may 2008
## 1785   1785  58   blue-collar  married   primary      no     -91     yes   no   unknown   9   may 2008
## 1786   1786  36   blue-collar  married secondary      no      -9     yes   no   unknown   9   may 2008
## 1787   1787  33   blue-collar  married   primary      no     134     yes   no   unknown   9   may 2008
## 1788   1788  32    management  married  tertiary      no       0      no   no   unknown   9   may 2008
## 1789   1789  32  entrepreneur   single  tertiary      no    6259     yes   no   unknown   9   may 2008
## 1790   1790  31        admin.  married secondary      no      27      no  yes   unknown   9   may 2008
## 1791   1791  30   blue-collar   single   primary      no     383     yes   no   unknown   9   may 2008
## 1792   1792  30    management   single  tertiary      no    1108     yes  yes   unknown   9   may 2008
## 1793   1793  40   blue-collar  married   primary      no     117     yes   no   unknown   9   may 2008
## 1794   1794  35   blue-collar  married   primary      no     108     yes   no   unknown   9   may 2008
## 1795   1795  42   blue-collar  married   primary      no     479     yes   no   unknown   9   may 2008
## 1796   1796  60    technician  married   primary      no      65     yes   no   unknown   9   may 2008
## 1797   1797  28      services   single secondary      no     234      no   no   unknown   9   may 2008
## 1798   1798  29        admin.   single secondary      no     -53     yes   no   unknown   9   may 2008
## 1799   1799  33    unemployed  married secondary      no    -131     yes  yes   unknown   9   may 2008
## 1800   1800  23      services   single secondary      no     -39     yes  yes   unknown   9   may 2008
## 1801   1801  34   blue-collar  married   primary      no     139     yes   no   unknown   9   may 2008
## 1802   1802  29      services   single secondary      no     262     yes   no   unknown   9   may 2008
## 1803   1803  32   blue-collar   single secondary      no     160     yes   no   unknown   9   may 2008
## 1804   1804  55      services  married secondary      no     186     yes  yes   unknown   9   may 2008
## 1805   1805  39       retired   single   primary      no     -79      no   no   unknown   9   may 2008
## 1806   1806  37        admin.   single secondary      no    1113     yes   no   unknown   9   may 2008
## 1807   1807  26   blue-collar   single secondary      no      82     yes   no   unknown   9   may 2008
## 1808   1808  35    management divorced  tertiary      no     321     yes   no   unknown   9   may 2008
## 1809   1809  26    management   single  tertiary      no    1326     yes   no   unknown   9   may 2008
## 1810   1810  34    technician   single  tertiary      no    2257     yes   no   unknown   9   may 2008
## 1811   1811  55   blue-collar  married   primary      no    1373      no   no   unknown   9   may 2008
## 1812   1812  39      services  married secondary      no     304     yes  yes   unknown   9   may 2008
## 1813   1813  27       student  married  tertiary      no     659     yes   no   unknown   9   may 2008
## 1814   1814  30  entrepreneur   single secondary      no     491     yes   no   unknown   9   may 2008
## 1815   1815  28    management   single   unknown     yes     101     yes   no   unknown   9   may 2008
## 1816   1816  33   blue-collar   single secondary      no      33     yes   no   unknown   9   may 2008
## 1817   1817  43    management  married  tertiary      no     291     yes   no   unknown   9   may 2008
## 1818   1818  50      services  married  tertiary      no     218     yes   no   unknown   9   may 2008
## 1819   1819  26   blue-collar   single   primary      no     102     yes   no   unknown   9   may 2008
## 1820   1820  33   blue-collar  married secondary      no      88     yes   no   unknown   9   may 2008
## 1821   1821  47   blue-collar  married   primary      no      94     yes   no   unknown   9   may 2008
## 1822   1822  33    management   single secondary      no    -665     yes  yes   unknown   9   may 2008
## 1823   1823  34   blue-collar  married secondary     yes    -331     yes  yes   unknown   9   may 2008
## 1824   1824  33   blue-collar   single secondary      no     550     yes   no   unknown   9   may 2008
## 1825   1825  23       student   single secondary      no     151     yes   no   unknown   9   may 2008
## 1826   1826  29 self-employed   single  tertiary      no    5406      no   no   unknown   9   may 2008
## 1827   1827  33   blue-collar  married secondary      no     269     yes   no   unknown   9   may 2008
## 1828   1828  41    management  married   unknown      no    2457     yes   no   unknown   9   may 2008
## 1829   1829  27   blue-collar   single secondary      no      45     yes   no   unknown   9   may 2008
## 1830   1830  34   blue-collar   single secondary      no     610     yes   no   unknown   9   may 2008
## 1831   1831  53    management  married secondary      no    -133     yes   no   unknown   9   may 2008
## 1832   1832  34    management   single secondary      no      66     yes   no   unknown   9   may 2008
## 1833   1833  40   blue-collar  married secondary      no      10     yes   no   unknown   9   may 2008
## 1834   1834  27   blue-collar  married  tertiary      no     350      no   no   unknown   9   may 2008
## 1835   1835  33      services  married  tertiary      no     546     yes  yes   unknown   9   may 2008
## 1836   1836  40    technician   single secondary      no     360     yes   no   unknown   9   may 2008
## 1837   1837  21       student   single secondary      no       6      no   no   unknown   9   may 2008
## 1838   1838  31   blue-collar  married secondary      no       0     yes   no   unknown   9   may 2008
## 1839   1839  51   blue-collar  married secondary      no      22     yes  yes   unknown   9   may 2008
## 1840   1840  26    technician   single secondary      no      57     yes   no   unknown   9   may 2008
## 1841   1841  26    management  married   primary      no    1349     yes   no   unknown   9   may 2008
## 1842   1842  32        admin.   single secondary      no     708      no   no   unknown   9   may 2008
## 1843   1843  31   blue-collar  married secondary      no    1329     yes  yes   unknown   9   may 2008
## 1844   1844  27    unemployed  married   primary      no    7459     yes   no   unknown   9   may 2008
## 1845   1845  58       retired divorced   primary      no      47     yes   no   unknown   9   may 2008
## 1846   1846  39      services  married   unknown      no    -516     yes   no   unknown   9   may 2008
## 1847   1847  30      services  married secondary      no       0     yes   no   unknown   9   may 2008
## 1848   1848  29    technician   single  tertiary      no     433     yes   no   unknown   9   may 2008
## 1849   1849  38    technician  married secondary     yes       9     yes   no   unknown   9   may 2008
## 1850   1850  29    management  married  tertiary      no      -6     yes   no   unknown   9   may 2008
## 1851   1851  28   blue-collar   single secondary      no    -197     yes   no   unknown   9   may 2008
## 1852   1852  41   blue-collar   single secondary      no     184     yes   no   unknown   9   may 2008
## 1853   1853  43   blue-collar  married   primary      no     336     yes   no   unknown   9   may 2008
## 1854   1854  43   blue-collar   single   primary      no      36     yes   no   unknown   9   may 2008
## 1855   1855  37    technician  married secondary      no     277     yes   no   unknown   9   may 2008
## 1856   1856  46   blue-collar divorced   primary      no     452     yes   no   unknown   9   may 2008
## 1857   1857  53   blue-collar  married secondary      no    -135     yes   no   unknown   9   may 2008
## 1858   1858  28   blue-collar   single secondary      no       7     yes  yes   unknown   9   may 2008
## 1859   1859  41        admin.  married secondary      no     442     yes  yes   unknown   9   may 2008
## 1860   1860  36   blue-collar  married secondary      no     590     yes   no   unknown   9   may 2008
## 1861   1861  37    technician  married  tertiary      no     447     yes   no   unknown   9   may 2008
## 1862   1862  38   blue-collar  married secondary      no      49     yes   no   unknown   9   may 2008
## 1863   1863  32    technician  married secondary      no    1118     yes  yes   unknown   9   may 2008
## 1864   1864  33   blue-collar divorced   primary      no     390     yes   no   unknown   9   may 2008
## 1865   1865  28    technician   single secondary      no    -125     yes   no   unknown   9   may 2008
## 1866   1866  52   blue-collar divorced   primary      no     -97     yes  yes   unknown   9   may 2008
## 1867   1867  30   blue-collar   single secondary      no      18      no   no   unknown   9   may 2008
## 1868   1868  37   blue-collar  married secondary      no     131     yes   no   unknown   9   may 2008
## 1869   1869  27    technician   single secondary      no     527     yes   no   unknown   9   may 2008
## 1870   1870  31      services  married secondary      no    1129     yes   no   unknown   9   may 2008
## 1871   1871  47    management divorced  tertiary      no     266     yes   no   unknown   9   may 2008
## 1872   1872  33   blue-collar   single secondary      no     687     yes   no   unknown   9   may 2008
## 1873   1873  46   blue-collar  married   primary      no    1726     yes  yes   unknown   9   may 2008
## 1874   1874  38   blue-collar  married secondary      no    -388     yes   no   unknown   9   may 2008
## 1875   1875  33   blue-collar   single   primary      no      92     yes   no   unknown   9   may 2008
## 1876   1876  44   blue-collar  married   primary      no     -11     yes   no   unknown   9   may 2008
## 1877   1877  35    management  married  tertiary      no    1510     yes   no   unknown   9   may 2008
## 1878   1878  38   blue-collar  married secondary      no     171     yes   no   unknown   9   may 2008
## 1879   1879  56   blue-collar  married   primary      no     420     yes   no   unknown   9   may 2008
## 1880   1880  33    technician   single secondary      no     513     yes   no   unknown   9   may 2008
## 1881   1881  45      services  married   primary      no     137     yes   no   unknown   9   may 2008
## 1882   1882  30      services  married   primary      no      21     yes   no   unknown   9   may 2008
## 1883   1883  34        admin.  married secondary      no    -312     yes   no   unknown   9   may 2008
## 1884   1884  32   blue-collar  married secondary      no    -208     yes  yes   unknown   9   may 2008
## 1885   1885  32   blue-collar   single secondary      no       2      no   no   unknown   9   may 2008
## 1886   1886  27        admin.  married secondary      no    1033     yes   no   unknown   9   may 2008
## 1887   1887  48    unemployed  married secondary      no     855     yes   no   unknown   9   may 2008
## 1888   1888  54   blue-collar  married   primary      no     781     yes   no   unknown   9   may 2008
## 1889   1889  29    technician   single  tertiary      no     542     yes   no   unknown   9   may 2008
## 1890   1890  37   blue-collar divorced secondary      no    -175     yes   no   unknown   9   may 2008
## 1891   1891  26  entrepreneur  married  tertiary      no      79     yes  yes   unknown   9   may 2008
## 1892   1892  43    management  married secondary      no       3     yes   no   unknown   9   may 2008
## 1893   1893  31   blue-collar  married secondary      no    4471     yes   no   unknown   9   may 2008
## 1894   1894  55    technician  married secondary      no    2313     yes   no   unknown   9   may 2008
## 1895   1895  45      services   single secondary      no    -139     yes   no   unknown   9   may 2008
## 1896   1896  35    technician   single secondary      no     300     yes   no   unknown   9   may 2008
## 1897   1897  57 self-employed  married  tertiary     yes   -3313     yes  yes   unknown   9   may 2008
## 1898   1898  49   blue-collar  married   primary      no     352     yes   no   unknown   9   may 2008
## 1899   1899  23      services   single secondary      no     105     yes  yes   unknown   9   may 2008
## 1900   1900  49     housemaid divorced   primary      no     164     yes   no   unknown   9   may 2008
## 1901   1901  35    management   single  tertiary      no    -202     yes   no   unknown   9   may 2008
## 1902   1902  38    technician   single  tertiary      no    -256     yes   no   unknown   9   may 2008
## 1903   1903  39  entrepreneur  married secondary      no    1261     yes   no   unknown   9   may 2008
## 1904   1904  27 self-employed   single  tertiary      no    -503     yes   no   unknown   9   may 2008
## 1905   1905  37   blue-collar  married secondary      no     790      no   no   unknown   9   may 2008
## 1906   1906  57    management  married secondary      no       0     yes   no   unknown   9   may 2008
## 1907   1907  38  entrepreneur   single  tertiary      no     638     yes   no   unknown   9   may 2008
## 1908   1908  26    technician  married secondary      no      47     yes   no   unknown   9   may 2008
## 1909   1909  46  entrepreneur  married   unknown      no     242     yes   no   unknown   9   may 2008
## 1910   1910  44        admin.  married secondary      no     469     yes   no   unknown   9   may 2008
## 1911   1911  44   blue-collar  married   primary      no     271     yes  yes   unknown   9   may 2008
## 1912   1912  28   blue-collar  married secondary      no     948     yes   no   unknown   9   may 2008
## 1913   1913  37        admin.  married secondary      no    -356      no  yes   unknown   9   may 2008
## 1914   1914  43    technician   single secondary      no     336     yes   no   unknown   9   may 2008
## 1915   1915  25        admin.   single secondary      no      61     yes   no   unknown   9   may 2008
## 1916   1916  34   blue-collar   single   primary      no     359     yes   no   unknown   9   may 2008
## 1917   1917  39   blue-collar  married   primary      no     105     yes   no   unknown   9   may 2008
## 1918   1918  35    management   single secondary      no    6809     yes   no   unknown   9   may 2008
## 1919   1919  32      services  married secondary      no      59     yes  yes   unknown   9   may 2008
## 1920   1920  31      services  married secondary      no       0      no  yes   unknown   9   may 2008
## 1921   1921  42   blue-collar  married   primary      no       0     yes   no   unknown   9   may 2008
## 1922   1922  31   blue-collar   single secondary      no     216     yes   no   unknown   9   may 2008
## 1923   1923  30    technician   single  tertiary      no    2530     yes   no   unknown   9   may 2008
## 1924   1924  29        admin.   single secondary      no     356     yes   no   unknown   9   may 2008
## 1925   1925  29        admin.   single secondary     yes    -228     yes   no   unknown   9   may 2008
## 1926   1926  36   blue-collar  married secondary      no     198     yes   no   unknown   9   may 2008
## 1927   1927  41      services  married secondary      no     510     yes   no   unknown   9   may 2008
## 1928   1928  37   blue-collar   single secondary      no     223     yes   no   unknown   9   may 2008
## 1929   1929  32    management   single  tertiary      no       4     yes   no   unknown   9   may 2008
## 1930   1930  39  entrepreneur  married  tertiary      no     338     yes   no   unknown   9   may 2008
## 1931   1931  31    management   single  tertiary      no       0     yes   no   unknown   9   may 2008
## 1932   1932  33   blue-collar   single secondary      no     328     yes   no   unknown   9   may 2008
## 1933   1933  30    technician   single  tertiary      no     255     yes   no   unknown   9   may 2008
## 1934   1934  24       student   single secondary      no     304      no   no   unknown   9   may 2008
## 1935   1935  55   blue-collar  married secondary      no    -256     yes  yes   unknown   9   may 2008
## 1936   1936  27      services   single secondary      no     683     yes   no   unknown   9   may 2008
## 1937   1937  47    management divorced  tertiary      no      84     yes   no   unknown   9   may 2008
## 1938   1938  29   blue-collar  married   primary      no     608     yes   no   unknown   9   may 2008
## 1939   1939  56    management  married secondary      no     230      no   no   unknown   9   may 2008
## 1940   1940  31    management   single  tertiary      no      12     yes   no   unknown   9   may 2008
## 1941   1941  46   blue-collar  married   primary      no     881     yes   no   unknown   9   may 2008
## 1942   1942  47    technician   single   unknown      no      77     yes   no   unknown   9   may 2008
## 1943   1943  29       student   single secondary      no     510     yes   no   unknown   9   may 2008
## 1944   1944  35        admin. divorced  tertiary      no    1555     yes   no   unknown   9   may 2008
## 1945   1945  31      services   single secondary     yes      68     yes   no   unknown   9   may 2008
## 1946   1946  29        admin.   single secondary      no      43     yes   no   unknown   9   may 2008
## 1947   1947  48        admin. divorced   unknown      no     244     yes   no   unknown   9   may 2008
## 1948   1948  59   blue-collar  married secondary      no    1376      no  yes   unknown   9   may 2008
## 1949   1949  44    management  married  tertiary      no     392     yes   no   unknown   9   may 2008
## 1950   1950  30        admin.   single  tertiary      no    -396     yes   no   unknown   9   may 2008
## 1951   1951  50   blue-collar  married   primary      no      89     yes   no   unknown   9   may 2008
## 1952   1952  25        admin.  married secondary      no      10     yes   no   unknown   9   may 2008
## 1953   1953  32   blue-collar  married secondary      no     150     yes   no   unknown   9   may 2008
## 1954   1954  49   blue-collar  married   primary      no    1387     yes  yes   unknown   9   may 2008
## 1955   1955  38        admin.  married secondary      no     253     yes   no   unknown   9   may 2008
## 1956   1956  29   blue-collar   single secondary      no     853     yes   no   unknown   9   may 2008
## 1957   1957  51    management  married  tertiary      no      91     yes   no   unknown   9   may 2008
## 1958   1958  29   blue-collar   single secondary      no     348     yes   no   unknown   9   may 2008
## 1959   1959  32        admin. divorced secondary      no      43     yes   no   unknown   9   may 2008
## 1960   1960  43    unemployed  married   primary      no    -178     yes   no   unknown   9   may 2008
## 1961   1961  34   blue-collar  married secondary      no    2137      no   no   unknown   9   may 2008
## 1962   1962  37   blue-collar  married   primary      no    1160     yes   no   unknown   9   may 2008
## 1963   1963  29        admin.   single secondary      no    3986     yes   no   unknown   9   may 2008
## 1964   1964  39      services   single secondary      no     126     yes   no   unknown   9   may 2008
## 1965   1965  34   blue-collar  married secondary      no    6411     yes  yes   unknown   9   may 2008
## 1966   1966  28    technician  married secondary      no     655     yes   no   unknown   9   may 2008
## 1967   1967  37   blue-collar  married   primary      no    2378     yes   no   unknown   9   may 2008
## 1968   1968  29   blue-collar  married secondary      no      15     yes  yes   unknown   9   may 2008
## 1969   1969  25        admin.   single secondary      no      96     yes   no   unknown   9   may 2008
## 1970   1970  33   blue-collar  married   primary      no     191     yes   no   unknown   9   may 2008
## 1971   1971  34        admin.   single secondary      no     391     yes   no   unknown   9   may 2008
## 1972   1972  50   blue-collar divorced   primary      no      31     yes   no   unknown   9   may 2008
## 1973   1973  35   blue-collar  married secondary      no      73      no   no   unknown   9   may 2008
## 1974   1974  53    management divorced  tertiary      no       0      no   no   unknown   9   may 2008
## 1975   1975  41   blue-collar   single   primary      no     156     yes   no   unknown   9   may 2008
## 1976   1976  48   blue-collar  married   primary      no     231     yes   no   unknown   9   may 2008
## 1977   1977  32   blue-collar   single secondary      no     -83     yes   no   unknown   9   may 2008
## 1978   1978  38 self-employed  married secondary      no     138      no   no   unknown   9   may 2008
## 1979   1979  57   blue-collar  married secondary      no     221     yes   no   unknown   9   may 2008
## 1980   1980  50    management  married  tertiary      no    3284     yes   no   unknown   9   may 2008
## 1981   1981  40    management  married  tertiary      no    4190      no   no   unknown   9   may 2008
## 1982   1982  45    management   single  tertiary      no    5694     yes   no   unknown   9   may 2008
## 1983   1983  34   blue-collar   single secondary      no     297     yes   no   unknown   9   may 2008
## 1984   1984  32   blue-collar  married   primary      no     -89     yes   no   unknown   9   may 2008
## 1985   1985  28        admin.   single secondary      no     244     yes   no   unknown   9   may 2008
## 1986   1986  30      services  married secondary      no     152     yes   no   unknown   9   may 2008
## 1987   1987  41    management   single  tertiary      no    1696     yes   no   unknown   9   may 2008
## 1988   1988  36   blue-collar  married   unknown      no     714      no   no   unknown   9   may 2008
## 1989   1989  49      services divorced secondary      no     315     yes   no   unknown   9   may 2008
## 1990   1990  32 self-employed  married  tertiary      no     312     yes   no   unknown   9   may 2008
## 1991   1991  53    management  married  tertiary      no     913     yes   no   unknown   9   may 2008
## 1992   1992  44    unemployed  married secondary      no    -407     yes   no   unknown   9   may 2008
## 1993   1993  34  entrepreneur divorced  tertiary      no     338     yes   no   unknown   9   may 2008
## 1994   1994  56        admin. divorced secondary     yes    -435     yes  yes   unknown   9   may 2008
## 1995   1995  27    technician   single secondary      no     769     yes   no   unknown   9   may 2008
## 1996   1996  32   blue-collar  married secondary      no     120     yes  yes   unknown   9   may 2008
## 1997   1997  43   blue-collar   single   primary      no       0      no   no   unknown   9   may 2008
## 1998   1998  34        admin. divorced   primary      no    9569     yes   no   unknown   9   may 2008
## 1999   1999  35 self-employed  married secondary      no     351     yes   no   unknown   9   may 2008
## 2000   2000  28        admin.  married secondary      no       2     yes   no   unknown   9   may 2008
## 2001   2001  52    management  married   primary      no     226     yes   no   unknown   9   may 2008
## 2002   2002  36   blue-collar  married   primary      no      95     yes   no   unknown   9   may 2008
## 2003   2003  35    management   single  tertiary      no     123     yes   no   unknown   9   may 2008
## 2004   2004  30        admin.  married secondary      no      15     yes   no   unknown   9   may 2008
## 2005   2005  23    management   single   unknown      no     375     yes   no   unknown   9   may 2008
## 2006   2006  37  entrepreneur divorced secondary      no    1190     yes   no   unknown   9   may 2008
## 2007   2007  29      services   single secondary      no     487     yes  yes   unknown   9   may 2008
## 2008   2008  28 self-employed   single secondary      no     123     yes   no   unknown   9   may 2008
## 2009   2009  56      services divorced  tertiary      no    2272     yes   no   unknown   9   may 2008
## 2010   2010  27        admin.  married secondary      no     133     yes  yes   unknown   9   may 2008
## 2011   2011  33   blue-collar   single   primary      no     447     yes   no   unknown   9   may 2008
## 2012   2012  53   blue-collar  married   primary      no    -864     yes   no   unknown   9   may 2008
## 2013   2013  47   blue-collar  married secondary      no       8      no   no   unknown   9   may 2008
## 2014   2014  50      services  married secondary      no     107     yes   no   unknown   9   may 2008
## 2015   2015  31        admin.   single secondary      no     620      no   no   unknown   9   may 2008
## 2016   2016  31   blue-collar  married secondary      no      42     yes   no   unknown   9   may 2008
## 2017   2017  37    management  married  tertiary      no    -120     yes   no   unknown   9   may 2008
## 2018   2018  37    management   single  tertiary      no     493     yes   no   unknown   9   may 2008
## 2019   2019  48    unemployed  married   primary      no     296     yes   no   unknown   9   may 2008
## 2020   2020  31    management   single  tertiary      no    6248     yes   no   unknown   9   may 2008
## 2021   2021  34    technician  married secondary      no     484      no   no   unknown   9   may 2008
## 2022   2022  32   blue-collar   single   primary      no      12     yes   no   unknown   9   may 2008
## 2023   2023  54    management  married  tertiary      no     154      no   no   unknown   9   may 2008
## 2024   2024  31    management   single  tertiary      no     606     yes   no   unknown   9   may 2008
## 2025   2025  55      services  married secondary      no     560     yes   no   unknown   9   may 2008
## 2026   2026  27   blue-collar  married secondary      no     564     yes   no   unknown   9   may 2008
## 2027   2027  36   blue-collar  married secondary      no     771     yes   no   unknown   9   may 2008
## 2028   2028  33    technician  married secondary      no       0     yes  yes   unknown   9   may 2008
## 2029   2029  43   blue-collar  married   primary      no     757     yes   no   unknown   9   may 2008
## 2030   2030  42   blue-collar  married secondary      no     333     yes   no   unknown   9   may 2008
## 2031   2031  48   blue-collar  married   primary      no     418     yes   no   unknown   9   may 2008
## 2032   2032  41        admin.   single secondary      no    -256      no  yes   unknown   9   may 2008
## 2033   2033  36    technician  married secondary      no     494     yes   no   unknown   9   may 2008
## 2034   2034  32      services   single secondary      no      85     yes   no   unknown   9   may 2008
## 2035   2035  58    management   single   unknown      no     127     yes   no   unknown   9   may 2008
## 2036   2036  40      services  married secondary      no      69     yes   no   unknown   9   may 2008
## 2037   2037  31    management  married  tertiary      no     713     yes   no   unknown   9   may 2008
## 2038   2038  42   blue-collar  married   primary      no     -10     yes   no   unknown   9   may 2008
## 2039   2039  34   blue-collar divorced secondary      no    -294     yes   no   unknown  12   may 2008
## 2040   2040  34    technician  married secondary      no     222     yes   no   unknown  12   may 2008
## 2041   2041  35    technician  married   unknown      no      86     yes   no   unknown  12   may 2008
## 2042   2042  57    management divorced secondary      no       0     yes  yes   unknown  12   may 2008
## 2043   2043  28   blue-collar  married   primary      no      26      no   no   unknown  12   may 2008
## 2044   2044  50    technician  married secondary      no     103     yes   no   unknown  12   may 2008
## 2045   2045  46 self-employed  married  tertiary      no     -80     yes   no   unknown  12   may 2008
## 2046   2046  28   blue-collar  married secondary      no     131     yes   no   unknown  12   may 2008
## 2047   2047  57       unknown  married   unknown      no     106      no   no   unknown  12   may 2008
## 2048   2048  49        admin.  married secondary     yes      15      no   no   unknown  12   may 2008
## 2049   2049  56    management   single  tertiary      no    4542      no   no   unknown  12   may 2008
## 2050   2050  56   blue-collar  married secondary      no     172     yes   no   unknown  12   may 2008
## 2051   2051  49    management divorced  tertiary     yes       0     yes   no   unknown  12   may 2008
## 2052   2052  50    management  married  tertiary      no     107     yes   no   unknown  12   may 2008
## 2053   2053  47        admin.   single secondary      no      15      no   no   unknown  12   may 2008
## 2054   2054  45   blue-collar  married   primary      no     101     yes   no   unknown  12   may 2008
## 2055   2055  44    unemployed  married secondary      no     304     yes   no   unknown  12   may 2008
## 2056   2056  51   blue-collar  married  tertiary      no    7816     yes   no   unknown  12   may 2008
## 2057   2057  34   blue-collar  married secondary      no       0     yes   no   unknown  12   may 2008
## 2058   2058  25    management  married  tertiary      no     784     yes  yes   unknown  12   may 2008
## 2059   2059  30   blue-collar  married   primary      no    2581      no   no   unknown  12   may 2008
## 2060   2060  39    unemployed divorced secondary      no     507     yes   no   unknown  12   may 2008
## 2061   2061  25       student  married  tertiary      no     333     yes   no   unknown  12   may 2008
## 2062   2062  34        admin. divorced secondary      no    -220     yes  yes   unknown  12   may 2008
## 2063   2063  25   blue-collar   single secondary      no     249     yes   no   unknown  12   may 2008
## 2064   2064  33   blue-collar  married secondary      no    -257     yes   no   unknown  12   may 2008
## 2065   2065  44      services divorced secondary      no     210      no  yes   unknown  12   may 2008
## 2066   2066  55       retired  married secondary      no   18722     yes   no   unknown  12   may 2008
## 2067   2067  54        admin.  married secondary      no      42     yes   no   unknown  12   may 2008
## 2068   2068  43    unemployed  married secondary      no     210     yes   no   unknown  12   may 2008
## 2069   2069  35   blue-collar  married secondary      no     325      no   no   unknown  12   may 2008
## 2070   2070  27      services   single secondary      no     123     yes   no   unknown  12   may 2008
## 2071   2071  42   blue-collar  married   primary      no     -25     yes   no   unknown  12   may 2008
## 2072   2072  40    technician  married secondary      no      66     yes   no   unknown  12   may 2008
## 2073   2073  31   blue-collar  married   primary      no       0     yes  yes   unknown  12   may 2008
## 2074   2074  29    technician  married  tertiary      no     409     yes   no   unknown  12   may 2008
## 2075   2075  49    technician  married secondary      no    4785      no   no   unknown  12   may 2008
## 2076   2076  59       retired divorced   primary      no     121     yes   no   unknown  12   may 2008
## 2077   2077  37    management  married  tertiary      no       0     yes   no   unknown  12   may 2008
## 2078   2078  60   blue-collar  married   unknown      no     231     yes   no   unknown  12   may 2008
## 2079   2079  25    technician   single secondary      no    1135     yes   no   unknown  12   may 2008
## 2080   2080  28        admin.  married secondary      no    -201     yes   no   unknown  12   may 2008
## 2081   2081  40      services   single secondary      no    -278     yes   no   unknown  12   may 2008
## 2082   2082  43    technician   single  tertiary      no      16     yes   no   unknown  12   may 2008
## 2083   2083  51   blue-collar  married   primary     yes    -283     yes   no   unknown  12   may 2008
## 2084   2084  28        admin.   single secondary      no    -103     yes   no   unknown  12   may 2008
## 2085   2085  54    management  married   primary      no     113      no   no   unknown  12   may 2008
## 2086   2086  37   blue-collar  married secondary      no     194     yes   no   unknown  12   may 2008
## 2087   2087  35 self-employed  married  tertiary      no     247     yes   no   unknown  12   may 2008
## 2088   2088  26    management divorced  tertiary     yes    -402      no  yes   unknown  12   may 2008
## 2089   2089  55      services   single secondary      no     -40     yes   no   unknown  12   may 2008
## 2090   2090  57    unemployed  married secondary      no    3867     yes   no   unknown  12   may 2008
## 2091   2091  39   blue-collar divorced secondary      no      36     yes   no   unknown  12   may 2008
## 2092   2092  36      services  married  tertiary      no    2167     yes  yes   unknown  12   may 2008
## 2093   2093  35    management   single  tertiary      no     243     yes   no   unknown  12   may 2008
## 2094   2094  33   blue-collar  married   primary      no       2     yes  yes   unknown  12   may 2008
## 2095   2095  40      services   single secondary      no     737     yes   no   unknown  12   may 2008
## 2096   2096  31    technician  married secondary      no     286      no   no   unknown  12   may 2008
## 2097   2097  32    management   single  tertiary      no     311      no   no   unknown  12   may 2008
## 2098   2098  27    management   single  tertiary      no     541     yes   no   unknown  12   may 2008
## 2099   2099  31      services   single secondary      no    2963     yes   no   unknown  12   may 2008
## 2100   2100  28   blue-collar   single secondary     yes    -871     yes   no   unknown  12   may 2008
## 2101   2101  33   blue-collar divorced secondary      no      75     yes  yes   unknown  12   may 2008
## 2102   2102  31   blue-collar   single secondary      no    2597     yes   no   unknown  12   may 2008
## 2103   2103  25      services  married secondary      no    -454     yes   no   unknown  12   may 2008
## 2104   2104  29    technician  married secondary      no       0      no   no   unknown  12   may 2008
## 2105   2105  47   blue-collar  married   primary      no     304     yes   no   unknown  12   may 2008
## 2106   2106  59   blue-collar divorced   primary      no     220     yes   no   unknown  12   may 2008
## 2107   2107  35    management   single  tertiary      no     561     yes   no   unknown  12   may 2008
## 2108   2108  33   blue-collar  married   primary      no     211     yes   no   unknown  12   may 2008
## 2109   2109  31    management   single  tertiary      no    4509     yes   no   unknown  12   may 2008
## 2110   2110  42    management   single  tertiary      no     196     yes   no   unknown  12   may 2008
## 2111   2111  26    technician   single secondary      no     124     yes   no   unknown  12   may 2008
## 2112   2112  34   blue-collar   single secondary      no     381     yes   no   unknown  12   may 2008
## 2113   2113  31        admin.  married secondary      no     184     yes   no   unknown  12   may 2008
## 2114   2114  30   blue-collar   single   unknown     yes    -149     yes  yes   unknown  12   may 2008
## 2115   2115  54        admin.  married   unknown      no    -337     yes   no   unknown  12   may 2008
## 2116   2116  52   blue-collar   single   primary      no     210     yes   no   unknown  12   may 2008
## 2117   2117  40   blue-collar divorced   primary      no     737     yes  yes   unknown  12   may 2008
## 2118   2118  56   blue-collar divorced secondary      no      75     yes   no   unknown  12   may 2008
## 2119   2119  25       student   single  tertiary      no     641     yes   no   unknown  12   may 2008
## 2120   2120  60       retired  married secondary      no      78     yes   no   unknown  12   may 2008
## 2121   2121  43   blue-collar  married   primary      no    1558     yes   no   unknown  12   may 2008
## 2122   2122  32  entrepreneur  married   unknown      no     227     yes   no   unknown  12   may 2008
## 2123   2123  48   blue-collar divorced secondary      no     602     yes   no   unknown  12   may 2008
## 2124   2124  43 self-employed   single secondary      no     798     yes   no   unknown  12   may 2008
## 2125   2125  37    technician  married secondary      no    1047     yes  yes   unknown  12   may 2008
## 2126   2126  52      services divorced   primary      no     111     yes   no   unknown  12   may 2008
## 2127   2127  25      services   single secondary      no    -439     yes   no   unknown  12   may 2008
## 2128   2128  31  entrepreneur   single  tertiary     yes      37     yes   no   unknown  12   may 2008
## 2129   2129  35   blue-collar  married secondary      no     362     yes   no   unknown  12   may 2008
## 2130   2130  27        admin.   single secondary      no       1     yes   no   unknown  12   may 2008
## 2131   2131  41 self-employed  married secondary      no     304     yes   no   unknown  12   may 2008
## 2132   2132  34    technician   single secondary      no     -89     yes   no   unknown  12   may 2008
## 2133   2133  55    technician  married secondary      no     276     yes   no   unknown  12   may 2008
## 2134   2134  26   blue-collar  married secondary      no     288     yes   no   unknown  12   may 2008
## 2135   2135  36   blue-collar  married   primary      no     650     yes   no   unknown  12   may 2008
## 2136   2136  45        admin.  married secondary      no     171     yes   no   unknown  12   may 2008
## 2137   2137  27    technician  married secondary      no    -302     yes   no   unknown  12   may 2008
## 2138   2138  31        admin.  married secondary      no     337      no   no   unknown  12   may 2008
## 2139   2139  29        admin. divorced secondary      no     891      no   no   unknown  12   may 2008
## 2140   2140  26   blue-collar   single secondary      no     199     yes  yes   unknown  12   may 2008
## 2141   2141  46      services  married secondary      no     997     yes   no   unknown  12   may 2008
## 2142   2142  32  entrepreneur  married  tertiary      no     108     yes  yes   unknown  12   may 2008
## 2143   2143  25        admin.   single  tertiary      no      40      no   no   unknown  12   may 2008
## 2144   2144  54       retired  married   primary      no     208      no   no   unknown  12   may 2008
## 2145   2145  31    technician  married secondary      no    6890     yes   no   unknown  12   may 2008
## 2146   2146  33        admin.   single secondary      no     395     yes   no   unknown  12   may 2008
## 2147   2147  28    technician   single  tertiary      no    -214     yes   no   unknown  12   may 2008
## 2148   2148  39        admin.   single secondary      no     496     yes   no   unknown  12   may 2008
## 2149   2149  37    technician  married secondary      no     183     yes   no   unknown  12   may 2008
## 2150   2150  36   blue-collar  married   primary      no     199     yes   no   unknown  12   may 2008
## 2151   2151  56        admin. divorced   primary      no     179     yes   no   unknown  12   may 2008
## 2152   2152  59       retired  married secondary      no     434     yes   no   unknown  12   may 2008
## 2153   2153  30      services   single secondary      no     122     yes   no   unknown  12   may 2008
## 2154   2154  59    technician  married secondary      no     371     yes   no   unknown  12   may 2008
## 2155   2155  27   blue-collar   single secondary      no    3675      no   no   unknown  12   may 2008
## 2156   2156  29  entrepreneur   single  tertiary      no      11     yes   no   unknown  12   may 2008
## 2157   2157  48      services  married secondary      no     194     yes  yes   unknown  12   may 2008
## 2158   2158  44   blue-collar  married secondary      no      23     yes   no   unknown  12   may 2008
## 2159   2159  33    management   single  tertiary      no    1011     yes   no   unknown  12   may 2008
## 2160   2160  39   blue-collar   single   primary      no     446     yes   no   unknown  12   may 2008
## 2161   2161  46   blue-collar  married   primary      no     -29     yes   no   unknown  12   may 2008
## 2162   2162  28        admin.  married secondary      no     957     yes  yes   unknown  12   may 2008
## 2163   2163  31   blue-collar  married secondary      no     297     yes   no   unknown  12   may 2008
## 2164   2164  40      services   single secondary      no     888     yes   no   unknown  12   may 2008
## 2165   2165  37   blue-collar   single secondary      no     115     yes   no   unknown  12   may 2008
## 2166   2166  29   blue-collar  married secondary      no     177     yes   no   unknown  12   may 2008
## 2167   2167  29   blue-collar  married secondary      no     -28     yes   no   unknown  12   may 2008
## 2168   2168  24   blue-collar  married secondary      no     951     yes   no   unknown  12   may 2008
## 2169   2169  32        admin.   single secondary      no       5     yes   no   unknown  12   may 2008
## 2170   2170  26        admin.   single secondary      no     586     yes  yes   unknown  12   may 2008
## 2171   2171  47  entrepreneur  married   unknown     yes   -1445     yes   no   unknown  12   may 2008
## 2172   2172  26   blue-collar   single secondary     yes     -23     yes   no   unknown  12   may 2008
## 2173   2173  28   blue-collar   single secondary      no    -284     yes   no   unknown  12   may 2008
## 2174   2174  58   blue-collar  married secondary      no    1166     yes   no   unknown  12   may 2008
## 2175   2175  35    management   single  tertiary      no     244     yes   no   unknown  12   may 2008
## 2176   2176  29      services   single secondary      no     -72     yes   no   unknown  12   may 2008
## 2177   2177  56   blue-collar  married   primary      no    1399     yes   no   unknown  12   may 2008
## 2178   2178  43   blue-collar  married   primary      no       0     yes   no   unknown  12   may 2008
## 2179   2179  45   blue-collar  married secondary      no     431     yes   no   unknown  12   may 2008
## 2180   2180  31        admin.   single secondary      no     130     yes  yes   unknown  12   may 2008
## 2181   2181  34   blue-collar  married secondary      no     187     yes   no   unknown  12   may 2008
## 2182   2182  32    management  married   primary      no     142     yes   no   unknown  12   may 2008
## 2183   2183  33    technician   single secondary      no      14     yes   no   unknown  12   may 2008
## 2184   2184  28    technician   single secondary      no    -219     yes   no   unknown  12   may 2008
## 2185   2185  43        admin.   single secondary      no     275     yes   no   unknown  12   may 2008
## 2186   2186  49      services   single secondary      no    5028     yes   no   unknown  12   may 2008
## 2187   2187  27      services   single secondary      no     118     yes  yes   unknown  12   may 2008
## 2188   2188  30      services   single secondary      no     290     yes   no   unknown  12   may 2008
## 2189   2189  32   blue-collar  married   primary      no    1064     yes   no   unknown  12   may 2008
## 2190   2190  37      services divorced secondary      no     904     yes   no   unknown  12   may 2008
## 2191   2191  31    technician   single secondary      no     628     yes   no   unknown  12   may 2008
## 2192   2192  56       retired  married   primary      no      13     yes   no   unknown  12   may 2008
## 2193   2193  26    technician  married  tertiary      no     450     yes  yes   unknown  12   may 2008
## 2194   2194  43   blue-collar  married secondary      no     -63     yes   no   unknown  12   may 2008
## 2195   2195  48    technician divorced secondary      no     164     yes   no   unknown  12   may 2008
## 2196   2196  31   blue-collar   single   primary      no     985     yes   no   unknown  12   may 2008
## 2197   2197  36      services   single secondary      no     616     yes  yes   unknown  12   may 2008
## 2198   2198  24   blue-collar  married secondary      no     237     yes   no   unknown  12   may 2008
## 2199   2199  29    unemployed  married secondary      no     380      no  yes   unknown  12   may 2008
## 2200   2200  23        admin.   single secondary      no     290     yes   no   unknown  12   may 2008
## 2201   2201  54  entrepreneur divorced secondary      no     104     yes   no   unknown  12   may 2008
## 2202   2202  24   blue-collar   single secondary      no     117     yes  yes   unknown  12   may 2008
## 2203   2203  25    technician   single secondary      no     276     yes   no   unknown  12   may 2008
## 2204   2204  36    technician   single secondary      no    -475     yes   no   unknown  12   may 2008
## 2205   2205  40    management   single   unknown      no     838     yes   no   unknown  12   may 2008
## 2206   2206  29        admin.   single secondary      no     382     yes   no   unknown  12   may 2008
## 2207   2207  29        admin.  married   primary      no     624     yes   no   unknown  12   may 2008
## 2208   2208  48   blue-collar   single   primary      no     396     yes   no   unknown  12   may 2008
## 2209   2209  23        admin.   single secondary      no       5      no   no   unknown  12   may 2008
## 2210   2210  37        admin.   single secondary      no      18      no   no   unknown  12   may 2008
## 2211   2211  31   blue-collar  married   primary      no    -464     yes  yes   unknown  12   may 2008
## 2212   2212  29      services divorced secondary      no     330     yes   no   unknown  12   may 2008
## 2213   2213  56        admin.  married secondary      no    2087     yes   no   unknown  12   may 2008
## 2214   2214  28      services   single secondary      no    -260     yes   no   unknown  12   may 2008
## 2215   2215  44   blue-collar  married secondary      no     236     yes   no   unknown  12   may 2008
## 2216   2216  48   blue-collar  married secondary      no     684     yes  yes   unknown  12   may 2008
## 2217   2217  30   blue-collar  married secondary      no     458     yes   no   unknown  12   may 2008
## 2218   2218  32    unemployed  married   primary      no     324     yes   no   unknown  12   may 2008
## 2219   2219  41   blue-collar  married   primary      no    1052     yes  yes   unknown  12   may 2008
## 2220   2220  30    management divorced secondary      no      37      no   no   unknown  12   may 2008
## 2221   2221  37   blue-collar  married secondary      no     454     yes   no   unknown  12   may 2008
## 2222   2222  30   blue-collar   single secondary      no     573     yes   no   unknown  12   may 2008
## 2223   2223  28    technician   single secondary      no      34     yes   no   unknown  12   may 2008
## 2224   2224  33    technician   single secondary      no     341      no  yes   unknown  12   may 2008
## 2225   2225  41   blue-collar  married   unknown      no      31      no   no   unknown  12   may 2008
## 2226   2226  42    management  married secondary      no    -189     yes   no   unknown  12   may 2008
## 2227   2227  50        admin.   single secondary      no     424     yes   no   unknown  12   may 2008
## 2228   2228  23       student   single  tertiary      no     250     yes   no   unknown  12   may 2008
## 2229   2229  38      services  married secondary      no    3165     yes   no   unknown  12   may 2008
## 2230   2230  31   blue-collar divorced secondary      no     387     yes   no   unknown  12   may 2008
## 2231   2231  35        admin.   single secondary      no     855     yes   no   unknown  12   may 2008
## 2232   2232  52        admin. divorced secondary      no     944     yes   no   unknown  12   may 2008
## 2233   2233  36   blue-collar  married secondary      no     134      no   no   unknown  12   may 2008
## 2234   2234  28   blue-collar   single secondary      no    2845     yes   no   unknown  12   may 2008
## 2235   2235  27    management   single  tertiary      no    2420     yes   no   unknown  12   may 2008
## 2236   2236  24       student   single  tertiary      no    1535     yes   no   unknown  12   may 2008
## 2237   2237  45    management   single  tertiary      no       0      no   no   unknown  12   may 2008
## 2238   2238  39    technician  married secondary      no     504     yes   no   unknown  12   may 2008
## 2239   2239  38   blue-collar   single secondary      no    -329     yes   no   unknown  12   may 2008
## 2240   2240  24   blue-collar  married secondary      no      94     yes   no   unknown  12   may 2008
## 2241   2241  35    management divorced  tertiary      no     538     yes   no   unknown  12   may 2008
## 2242   2242  32        admin. divorced secondary     yes     -18     yes   no   unknown  12   may 2008
## 2243   2243  48     housemaid divorced   primary      no      26     yes   no   unknown  12   may 2008
## 2244   2244  36  entrepreneur  married   primary      no     177     yes   no   unknown  12   may 2008
## 2245   2245  46   blue-collar  married   primary      no     633     yes   no   unknown  12   may 2008
## 2246   2246  28    technician   single secondary      no     205     yes   no   unknown  12   may 2008
## 2247   2247  50        admin.  married secondary      no    1114     yes  yes   unknown  12   may 2008
## 2248   2248  44   blue-collar  married secondary      no      78     yes   no   unknown  12   may 2008
## 2249   2249  38    management  married  tertiary      no     762     yes   no   unknown  12   may 2008
## 2250   2250  33 self-employed  married   primary      no    1862     yes   no   unknown  12   may 2008
## 2251   2251  57    management   single  tertiary      no      73      no   no   unknown  12   may 2008
## 2252   2252  40    technician  married secondary      no    2576     yes  yes   unknown  12   may 2008
## 2253   2253  42    management  married   primary      no     470     yes   no   unknown  12   may 2008
## 2254   2254  32      services  married secondary      no     206     yes  yes   unknown  12   may 2008
## 2255   2255  55   blue-collar  married   primary      no       0     yes  yes   unknown  12   may 2008
## 2256   2256  25   blue-collar  married secondary      no     -76     yes   no   unknown  12   may 2008
## 2257   2257  42    management divorced  tertiary      no    1750     yes   no   unknown  12   may 2008
## 2258   2258  23        admin.   single secondary      no    1104     yes   no   unknown  12   may 2008
## 2259   2259  31   blue-collar  married secondary      no     286     yes  yes   unknown  12   may 2008
## 2260   2260  21       student   single   unknown      no     137     yes   no   unknown  12   may 2008
## 2261   2261  34        admin.  married secondary      no     247     yes  yes   unknown  12   may 2008
## 2262   2262  46  entrepreneur  married  tertiary      no     -43      no   no   unknown  12   may 2008
## 2263   2263  55   blue-collar  married   primary      no     309     yes   no   unknown  12   may 2008
## 2264   2264  33  entrepreneur   single secondary      no     339     yes   no   unknown  12   may 2008
## 2265   2265  47 self-employed divorced secondary      no     218     yes   no   unknown  12   may 2008
## 2266   2266  33    management   single  tertiary      no    4128     yes   no   unknown  12   may 2008
## 2267   2267  40    management   single  tertiary      no     867     yes  yes   unknown  12   may 2008
## 2268   2268  32    management   single  tertiary      no    1345     yes   no   unknown  12   may 2008
## 2269   2269  48    technician divorced secondary      no      40      no   no   unknown  12   may 2008
## 2270   2270  32        admin.   single secondary      no    1466     yes   no   unknown  12   may 2008
## 2271   2271  26   blue-collar   single secondary      no      96     yes   no   unknown  12   may 2008
## 2272   2272  38   blue-collar  married secondary      no     332     yes   no   unknown  12   may 2008
## 2273   2273  46      services  married secondary      no    1474     yes   no   unknown  12   may 2008
## 2274   2274  49   blue-collar  married secondary      no     783     yes   no   unknown  12   may 2008
## 2275   2275  33    management   single  tertiary      no     239      no   no   unknown  12   may 2008
## 2276   2276  45   blue-collar  married secondary      no      27     yes   no   unknown  12   may 2008
## 2277   2277  32    management  married  tertiary      no     -24     yes   no   unknown  12   may 2008
## 2278   2278  39   blue-collar  married secondary      no      23     yes   no   unknown  12   may 2008
## 2279   2279  53   blue-collar  married   primary      no    6386     yes   no   unknown  12   may 2008
## 2280   2280  28    unemployed   single secondary     yes    -353     yes   no   unknown  12   may 2008
## 2281   2281  31        admin.  married secondary      no    -474     yes   no   unknown  12   may 2008
## 2282   2282  34  entrepreneur   single  tertiary      no     714     yes   no   unknown  12   may 2008
## 2283   2283  40   blue-collar  married   primary      no     570     yes   no   unknown  12   may 2008
## 2284   2284  29   blue-collar   single secondary      no      16      no   no   unknown  12   may 2008
## 2285   2285  34        admin.   single secondary      no    1504     yes   no   unknown  12   may 2008
## 2286   2286  38    management  married  tertiary      no     551     yes   no   unknown  12   may 2008
## 2287   2287  31      services  married secondary      no    -759     yes   no   unknown  12   may 2008
## 2288   2288  32    technician divorced secondary      no    1097     yes   no   unknown  12   may 2008
## 2289   2289  31      services  married secondary      no     520     yes   no   unknown  12   may 2008
## 2290   2290  53   blue-collar   single   unknown      no       0      no   no   unknown  12   may 2008
## 2291   2291  38   blue-collar   single   unknown      no     573     yes   no   unknown  12   may 2008
## 2292   2292  57   blue-collar  married   primary     yes       0     yes   no   unknown  12   may 2008
## 2293   2293  58  entrepreneur  married  tertiary      no     146     yes   no   unknown  12   may 2008
## 2294   2294  50   blue-collar  married   primary      no     -37     yes   no   unknown  12   may 2008
## 2295   2295  36   blue-collar   single secondary      no      90     yes   no   unknown  12   may 2008
## 2296   2296  46   blue-collar  married   primary      no       0     yes   no   unknown  12   may 2008
## 2297   2297  39        admin.   single secondary      no    1242     yes   no   unknown  12   may 2008
## 2298   2298  31        admin.   single secondary      no      98     yes  yes   unknown  12   may 2008
## 2299   2299  44    management   single  tertiary      no     295     yes   no   unknown  12   may 2008
## 2300   2300  53        admin.  married secondary      no     465      no  yes   unknown  12   may 2008
## 2301   2301  35    technician  married  tertiary      no    1473     yes   no   unknown  12   may 2008
## 2302   2302  40   blue-collar  married secondary      no    3122     yes   no   unknown  12   may 2008
## 2303   2303  30    technician   single secondary      no     317     yes   no   unknown  12   may 2008
## 2304   2304  33   blue-collar divorced secondary      no     176     yes   no   unknown  12   may 2008
## 2305   2305  39   blue-collar  married secondary      no     661     yes   no   unknown  12   may 2008
## 2306   2306  25        admin.   single secondary      no       1     yes  yes   unknown  12   may 2008
## 2307   2307  35   blue-collar  married   primary      no     -12     yes   no   unknown  12   may 2008
## 2308   2308  43   blue-collar  married   primary      no    1401     yes   no   unknown  12   may 2008
## 2309   2309  41  entrepreneur  married  tertiary      no     171     yes   no   unknown  12   may 2008
## 2310   2310  55   blue-collar  married   primary      no     431     yes   no   unknown  12   may 2008
## 2311   2311  49    technician divorced secondary      no     265     yes   no   unknown  12   may 2008
## 2312   2312  30 self-employed  married  tertiary      no     227     yes  yes   unknown  12   may 2008
## 2313   2313  37   blue-collar   single secondary      no     336     yes   no   unknown  12   may 2008
## 2314   2314  46    unemployed divorced secondary      no      41     yes   no   unknown  12   may 2008
## 2315   2315  36   blue-collar  married secondary      no    1554     yes   no   unknown  12   may 2008
## 2316   2316  45      services   single secondary      no     141     yes   no   unknown  12   may 2008
## 2317   2317  48   blue-collar  married   primary      no     762     yes   no   unknown  12   may 2008
## 2318   2318  22     housemaid   single secondary      no     650     yes   no   unknown  12   may 2008
## 2319   2319  46        admin.  married secondary      no     250      no   no   unknown  13   may 2008
## 2320   2320  39   blue-collar  married secondary      no     130     yes   no   unknown  13   may 2008
## 2321   2321  56        admin.  married secondary      no      11      no   no   unknown  13   may 2008
## 2322   2322  35    management divorced  tertiary      no      36     yes   no   unknown  13   may 2008
## 2323   2323  45   blue-collar  married   primary      no     333     yes   no   unknown  13   may 2008
## 2324   2324  28    technician  married secondary      no     487     yes   no   unknown  13   may 2008
## 2325   2325  32        admin.   single  tertiary      no     594     yes   no   unknown  13   may 2008
## 2326   2326  52      services  married  tertiary      no    1135     yes  yes   unknown  13   may 2008
## 2327   2327  26        admin. divorced secondary     yes      -3     yes   no   unknown  13   may 2008
## 2328   2328  22   blue-collar   single   primary      no    -168     yes   no   unknown  13   may 2008
## 2329   2329  35   blue-collar  married   primary      no     414      no   no   unknown  13   may 2008
## 2330   2330  44    technician   single  tertiary      no     166     yes   no   unknown  13   may 2008
## 2331   2331  31   blue-collar  married secondary      no     472     yes   no   unknown  13   may 2008
## 2332   2332  28   blue-collar  married secondary      no     -95     yes   no   unknown  13   may 2008
## 2333   2333  23    technician   single secondary      no     158     yes   no   unknown  13   may 2008
## 2334   2334  26    technician   single secondary      no       8      no   no   unknown  13   may 2008
## 2335   2335  31        admin.   single secondary      no     296     yes   no   unknown  13   may 2008
## 2336   2336  27        admin.   single secondary      no    -541     yes  yes   unknown  13   may 2008
## 2337   2337  34      services   single secondary      no      23      no   no   unknown  13   may 2008
## 2338   2338  25   blue-collar   single   primary      no      17     yes   no   unknown  13   may 2008
## 2339   2339  25   blue-collar   single secondary      no     335     yes   no   unknown  13   may 2008
## 2340   2340  22      services   single secondary      no     395     yes   no   unknown  13   may 2008
## 2341   2341  37   blue-collar divorced secondary      no     178     yes   no   unknown  13   may 2008
## 2342   2342  26  entrepreneur   single secondary      no     101     yes   no   unknown  13   may 2008
## 2343   2343  32   blue-collar  married secondary      no    -428     yes   no   unknown  13   may 2008
## 2344   2344  26    technician   single secondary      no   24299     yes   no   unknown  13   may 2008
## 2345   2345  27   blue-collar   single secondary      no     181      no   no   unknown  13   may 2008
## 2346   2346  22      services  married secondary      no      83     yes   no   unknown  13   may 2008
## 2347   2347  32    technician  married secondary      no     175     yes   no   unknown  13   may 2008
## 2348   2348  33    management divorced secondary      no       5     yes   no   unknown  13   may 2008
## 2349   2349  34        admin.  married secondary      no    3185     yes   no   unknown  13   may 2008
## 2350   2350  31   blue-collar  married secondary      no    2577     yes   no   unknown  13   may 2008
## 2351   2351  28    technician   single secondary      no     216     yes   no   unknown  13   may 2008
## 2352   2352  37   blue-collar  married secondary      no     166     yes   no   unknown  13   may 2008
## 2353   2353  45   blue-collar  married   primary      no     323     yes   no   unknown  13   may 2008
## 2354   2354  31    management  married  tertiary      no     334     yes   no   unknown  13   may 2008
## 2355   2355  48  entrepreneur  married secondary      no      86     yes   no   unknown  13   may 2008
## 2356   2356  24        admin.   single secondary      no     845     yes   no   unknown  13   may 2008
## 2357   2357  24    technician   single secondary      no    -126     yes  yes   unknown  13   may 2008
## 2358   2358  45      services  married secondary      no      -3     yes   no   unknown  13   may 2008
## 2359   2359  26      services  married secondary      no      54     yes   no   unknown  13   may 2008
## 2360   2360  24    technician   single secondary      no    -192     yes   no   unknown  13   may 2008
## 2361   2361  29   blue-collar  married secondary      no     125     yes   no   unknown  13   may 2008
## 2362   2362  34   blue-collar   single   primary      no    2146     yes   no   unknown  13   may 2008
## 2363   2363  30    technician   single  tertiary      no    -522     yes   no   unknown  13   may 2008
## 2364   2364  21       student   single secondary      no      99     yes   no   unknown  13   may 2008
## 2365   2365  42   blue-collar  married secondary      no   -1664     yes   no   unknown  13   may 2008
## 2366   2366  32    unemployed  married secondary     yes       2     yes   no   unknown  13   may 2008
## 2367   2367  40      services  married secondary      no    2172     yes  yes   unknown  13   may 2008
## 2368   2368  33    management   single  tertiary      no     168     yes   no   unknown  13   may 2008
## 2369   2369  32    technician  married   primary      no      62     yes  yes   unknown  13   may 2008
## 2370   2370  25        admin.   single secondary      no     768     yes   no   unknown  13   may 2008
## 2371   2371  41   blue-collar  married secondary      no     429     yes   no   unknown  13   may 2008
## 2372   2372  37        admin.  married secondary      no      36     yes   no   unknown  13   may 2008
## 2373   2373  29   blue-collar  married   primary      no       0     yes   no   unknown  13   may 2008
## 2374   2374  29    technician   single secondary      no     544     yes   no   unknown  13   may 2008
## 2375   2375  46      services divorced   primary      no      91     yes   no   unknown  13   may 2008
## 2376   2376  32    management   single  tertiary     yes      -3     yes   no   unknown  13   may 2008
## 2377   2377  30        admin.   single secondary      no    1374     yes   no   unknown  13   may 2008
## 2378   2378  38    management  married  tertiary      no     119     yes   no   unknown  13   may 2008
## 2379   2379  22      services   single secondary      no     279     yes   no   unknown  13   may 2008
## 2380   2380  22    management   single secondary      no     594     yes   no   unknown  13   may 2008
## 2381   2381  32      services   single secondary      no    -121     yes  yes   unknown  13   may 2008
## 2382   2382  36   blue-collar  married secondary      no    -195     yes   no   unknown  13   may 2008
## 2383   2383  30    technician   single secondary      no    -208     yes  yes   unknown  13   may 2008
## 2384   2384  26   blue-collar   single secondary      no     309     yes   no   unknown  13   may 2008
## 2385   2385  41   blue-collar divorced   primary     yes     210     yes   no   unknown  13   may 2008
## 2386   2386  42    unemployed  married secondary      no     135     yes   no   unknown  13   may 2008
## 2387   2387  45   blue-collar  married secondary      no      66     yes   no   unknown  13   may 2008
## 2388   2388  24      services   single secondary     yes    -122     yes   no   unknown  13   may 2008
## 2389   2389  54       retired divorced  tertiary      no       0      no   no   unknown  13   may 2008
## 2390   2390  33   blue-collar   single   unknown      no     -90     yes   no   unknown  13   may 2008
## 2391   2391  28   blue-collar  married   primary      no     286     yes   no   unknown  13   may 2008
## 2392   2392  36        admin.  married secondary      no    -423     yes  yes   unknown  13   may 2008
## 2393   2393  34   blue-collar   single   primary      no     505     yes   no   unknown  13   may 2008
## 2394   2394  28        admin.   single secondary      no     296     yes   no   unknown  13   may 2008
## 2395   2395  31    technician   single  tertiary      no     279     yes   no   unknown  13   may 2008
## 2396   2396  53      services  married secondary      no     367     yes  yes   unknown  13   may 2008
## 2397   2397  20   blue-collar   single secondary      no     129     yes  yes   unknown  13   may 2008
## 2398   2398  47       retired  married   primary     yes     -13      no   no   unknown  13   may 2008
## 2399   2399  33   blue-collar  married   primary      no    1309     yes   no   unknown  13   may 2008
## 2400   2400  24   blue-collar   single secondary      no     -10     yes   no   unknown  13   may 2008
## 2401   2401  23        admin.   single secondary      no       5     yes   no   unknown  13   may 2008
## 2402   2402  27   blue-collar   single secondary      no      71     yes   no   unknown  13   may 2008
## 2403   2403  23        admin.   single secondary      no     281     yes   no   unknown  13   may 2008
## 2404   2404  30   blue-collar  married secondary      no     173     yes   no   unknown  13   may 2008
## 2405   2405  34   blue-collar divorced secondary      no     383     yes   no   unknown  13   may 2008
## 2406   2406  55   blue-collar divorced   primary      no      39     yes   no   unknown  13   may 2008
## 2407   2407  57    management  married   primary      no    1052     yes   no   unknown  13   may 2008
## 2408   2408  59       retired divorced   unknown      no     -49     yes   no   unknown  13   may 2008
## 2409   2409  20      services   single secondary      no    -103     yes   no   unknown  13   may 2008
## 2410   2410  30      services  married secondary     yes    -846     yes   no   unknown  13   may 2008
## 2411   2411  41        admin.  married secondary      no     705     yes   no   unknown  13   may 2008
## 2412   2412  37      services   single secondary      no    1950     yes   no   unknown  13   may 2008
## 2413   2413  31        admin. divorced secondary      no     253     yes   no   unknown  13   may 2008
## 2414   2414  39    management   single  tertiary      no     595     yes   no   unknown  13   may 2008
## 2415   2415  28   blue-collar  married secondary      no    -185     yes  yes   unknown  13   may 2008
## 2416   2416  44   blue-collar  married   primary      no     353     yes   no   unknown  13   may 2008
## 2417   2417  31    technician  married secondary      no    2363     yes   no   unknown  13   may 2008
## 2418   2418  28   blue-collar  married   unknown      no      52     yes   no   unknown  13   may 2008
## 2419   2419  51    technician  married   unknown      no     205     yes  yes   unknown  13   may 2008
## 2420   2420  34    management  married  tertiary      no    1557     yes  yes   unknown  13   may 2008
## 2421   2421  24    technician   single  tertiary      no     596     yes   no   unknown  13   may 2008
## 2422   2422  29 self-employed   single  tertiary      no    -114     yes   no   unknown  13   may 2008
## 2423   2423  50    management  married   primary      no     478      no   no   unknown  13   may 2008
## 2424   2424  21   blue-collar   single secondary      no     614     yes   no   unknown  13   may 2008
## 2425   2425  29   blue-collar   single secondary      no     783     yes   no   unknown  13   may 2008
## 2426   2426  26   blue-collar   single secondary      no     401     yes   no   unknown  13   may 2008
## 2427   2427  26        admin.   single secondary      no      92     yes   no   unknown  13   may 2008
## 2428   2428  21   blue-collar   single secondary      no    -273     yes  yes   unknown  13   may 2008
## 2429   2429  23   blue-collar   single   primary      no    2594     yes   no   unknown  13   may 2008
## 2430   2430  25      services   single secondary      no     382     yes   no   unknown  13   may 2008
## 2431   2431  40   blue-collar  married   primary      no    -166     yes   no   unknown  13   may 2008
## 2432   2432  39        admin. divorced secondary      no    -141     yes   no   unknown  13   may 2008
## 2433   2433  25   blue-collar   single secondary      no    -250     yes   no   unknown  13   may 2008
## 2434   2434  26    technician  married  tertiary      no    3825     yes   no   unknown  13   may 2008
## 2435   2435  57    technician  married secondary      no       0      no   no   unknown  13   may 2008
## 2436   2436  61       retired  married   primary      no    1060     yes   no   unknown  13   may 2008
## 2437   2437  34   blue-collar  married secondary      no    -185     yes  yes   unknown  13   may 2008
## 2438   2438  47    unemployed  married secondary      no     955     yes   no   unknown  13   may 2008
## 2439   2439  31 self-employed  married secondary      no     263     yes   no   unknown  13   may 2008
## 2440   2440  45   blue-collar  married secondary      no    4646     yes   no   unknown  13   may 2008
## 2441   2441  33    technician   single  tertiary      no     989     yes  yes   unknown  13   may 2008
## 2442   2442  27    technician  married secondary      no     232     yes  yes   unknown  13   may 2008
## 2443   2443  41    unemployed  married   primary      no    1483     yes   no   unknown  13   may 2008
## 2444   2444  58    technician  married secondary      no    7495     yes   no   unknown  13   may 2008
## 2445   2445  45    management  married  tertiary      no       0     yes  yes   unknown  13   may 2008
## 2446   2446  49 self-employed  married  tertiary      no    2199     yes   no   unknown  13   may 2008
## 2447   2447  42   blue-collar  married secondary      no     476     yes   no   unknown  13   may 2008
## 2448   2448  52   blue-collar  married secondary      no     148     yes   no   unknown  13   may 2008
## 2449   2449  52      services  married secondary      no    3241     yes   no   unknown  13   may 2008
## 2450   2450  49       retired  married   primary      no    2665     yes   no   unknown  13   may 2008
## 2451   2451  59       retired  married secondary      no    1875     yes   no   unknown  13   may 2008
## 2452   2452  54    management  married   primary      no     879     yes   no   unknown  13   may 2008
## 2453   2453  46   blue-collar  married secondary      no    1934     yes   no   unknown  13   may 2008
## 2454   2454  44    management  married  tertiary      no       0      no   no   unknown  13   may 2008
## 2455   2455  26      services  married secondary      no     380     yes   no   unknown  13   may 2008
## 2456   2456  46   blue-collar  married secondary      no    2485     yes   no   unknown  13   may 2008
## 2457   2457  59       retired  married   primary      no    5521     yes  yes   unknown  13   may 2008
## 2458   2458  43   blue-collar  married   unknown      no      24     yes   no   unknown  13   may 2008
## 2459   2459  50   blue-collar  married secondary      no     160     yes   no   unknown  13   may 2008
## 2460   2460  26   blue-collar   single secondary      no    -204     yes   no   unknown  13   may 2008
## 2461   2461  54   blue-collar  married   unknown      no     363     yes   no   unknown  13   may 2008
## 2462   2462  44    technician divorced secondary      no     181      no   no   unknown  13   may 2008
## 2463   2463  36        admin. divorced secondary      no     307     yes   no   unknown  13   may 2008
## 2464   2464  51      services  married   unknown      no     193     yes   no   unknown  13   may 2008
## 2465   2465  59       retired  married secondary      no    3382     yes   no   unknown  13   may 2008
## 2466   2466  42    management  married  tertiary      no    1823     yes   no   unknown  13   may 2008
## 2467   2467  41      services  married secondary      no    -111     yes   no   unknown  13   may 2008
## 2468   2468  43   blue-collar  married   unknown      no    3373     yes   no   unknown  13   may 2008
## 2469   2469  40 self-employed  married   primary      no      92     yes   no   unknown  13   may 2008
## 2470   2470  32    technician  married  tertiary      no     463     yes   no   unknown  13   may 2008
## 2471   2471  55    technician  married   unknown      no    1192     yes   no   unknown  13   may 2008
## 2472   2472  59       retired  married secondary      no    2376      no   no   unknown  13   may 2008
## 2473   2473  30   blue-collar  married secondary      no    -166     yes  yes   unknown  13   may 2008
## 2474   2474  47        admin.  married secondary      no    3960     yes   no   unknown  13   may 2008
## 2475   2475  23  entrepreneur   single   primary      no       4     yes   no   unknown  13   may 2008
## 2476   2476  44   blue-collar  married   primary      no      23     yes   no   unknown  13   may 2008
## 2477   2477  45    technician  married secondary      no     639     yes   no   unknown  13   may 2008
## 2478   2478  35    technician   single secondary      no    2144     yes   no   unknown  13   may 2008
## 2479   2479  41    technician divorced secondary      no     225     yes  yes   unknown  13   may 2008
## 2480   2480  59    management divorced   primary      no   13308     yes   no   unknown  13   may 2008
## 2481   2481  29      services   single   primary      no      95     yes   no   unknown  13   may 2008
## 2482   2482  48      services  married secondary      no    1199     yes   no   unknown  13   may 2008
## 2483   2483  49    management  married  tertiary      no     400     yes   no   unknown  13   may 2008
## 2484   2484  60   blue-collar  married   primary      no    1262     yes  yes   unknown  13   may 2008
## 2485   2485  45    management  married  tertiary      no     849      no   no   unknown  13   may 2008
## 2486   2486  48    management  married  tertiary      no    1949     yes   no   unknown  13   may 2008
## 2487   2487  45  entrepreneur divorced  tertiary      no    -395     yes   no   unknown  13   may 2008
## 2488   2488  48    management  married  tertiary      no     618      no   no   unknown  13   may 2008
## 2489   2489  54       retired  married   primary      no       0     yes   no   unknown  13   may 2008
## 2490   2490  44    technician  married  tertiary      no       0     yes  yes   unknown  13   may 2008
## 2491   2491  46   blue-collar   single   primary      no     355     yes   no   unknown  13   may 2008
## 2492   2492  52        admin. divorced secondary      no     131     yes  yes   unknown  13   may 2008
## 2493   2493  44    management  married  tertiary      no    6203     yes  yes   unknown  13   may 2008
## 2494   2494  52      services divorced secondary      no    1635     yes   no   unknown  13   may 2008
## 2495   2495  46  entrepreneur   single  tertiary      no     580     yes   no   unknown  13   may 2008
## 2496   2496  54        admin. divorced secondary      no    1814      no   no   unknown  13   may 2008
## 2497   2497  49  entrepreneur divorced secondary      no     159     yes   no   unknown  13   may 2008
## 2498   2498  46    management  married  tertiary      no      48      no   no   unknown  13   may 2008
## 2499   2499  48      services divorced   primary      no     189     yes   no   unknown  13   may 2008
## 2500   2500  43   blue-collar  married   unknown      no    -633     yes  yes   unknown  13   may 2008
## 2501   2501  50   blue-collar  married   primary      no    5356      no   no   unknown  13   may 2008
## 2502   2502  44   blue-collar  married secondary      no     476     yes   no   unknown  13   may 2008
## 2503   2503  43    unemployed divorced secondary      no    4478     yes   no   unknown  13   may 2008
## 2504   2504  51        admin.   single secondary      no    3132      no   no   unknown  13   may 2008
## 2505   2505  59       retired  married  tertiary      no    -892     yes   no   unknown  13   may 2008
## 2506   2506  52    technician  married secondary      no      11     yes   no   unknown  13   may 2008
## 2507   2507  35        admin.   single secondary      no     414     yes   no   unknown  13   may 2008
## 2508   2508  36   blue-collar  married secondary      no    1165     yes   no   unknown  13   may 2008
## 2509   2509  32      services  married secondary      no    3839     yes   no   unknown  13   may 2008
## 2510   2510  41   blue-collar  married secondary      no     196     yes   no   unknown  13   may 2008
## 2511   2511  47   blue-collar  married   primary      no     521     yes   no   unknown  13   may 2008
## 2512   2512  45      services  married secondary      no     350     yes  yes   unknown  13   may 2008
## 2513   2513  45   blue-collar  married secondary      no    8680     yes   no   unknown  13   may 2008
## 2514   2514  45  entrepreneur divorced  tertiary      no       0     yes   no   unknown  13   may 2008
## 2515   2515  29    technician   single secondary      no     309     yes   no   unknown  13   may 2008
## 2516   2516  36    management  married  tertiary      no     125     yes   no   unknown  13   may 2008
## 2517   2517  37   blue-collar divorced secondary      no     368     yes   no   unknown  13   may 2008
## 2518   2518  44        admin.  married secondary      no    1362     yes   no   unknown  13   may 2008
## 2519   2519  56       retired  married secondary      no     296     yes   no   unknown  13   may 2008
## 2520   2520  52    management  married   unknown      no    2240     yes   no   unknown  13   may 2008
## 2521   2521  57    management  married secondary      no    1026     yes   no   unknown  13   may 2008
## 2522   2522  54      services  married secondary      no    1301     yes   no   unknown  13   may 2008
## 2523   2523  49  entrepreneur  married   primary      no     199      no   no   unknown  13   may 2008
## 2524   2524  24   blue-collar   single   unknown      no      11     yes   no   unknown  13   may 2008
## 2525   2525  42 self-employed  married  tertiary      no       5     yes   no   unknown  13   may 2008
## 2526   2526  40    management  married  tertiary      no     373     yes  yes   unknown  13   may 2008
## 2527   2527  25    management   single  tertiary      no    1270     yes   no   unknown  13   may 2008
## 2528   2528  28   blue-collar   single secondary      no     416     yes   no   unknown  13   may 2008
## 2529   2529  53       retired  married secondary      no     -27      no   no   unknown  13   may 2008
## 2530   2530  40        admin. divorced secondary      no     221     yes   no   unknown  13   may 2008
## 2531   2531  27      services   single secondary      no     331     yes   no   unknown  13   may 2008
## 2532   2532  34    management  married  tertiary      no     402     yes   no   unknown  13   may 2008
## 2533   2533  56 self-employed  married secondary      no     123      no   no   unknown  13   may 2008
## 2534   2534  45   blue-collar  married secondary      no     105     yes  yes   unknown  13   may 2008
## 2535   2535  27   blue-collar  married secondary      no       0     yes   no   unknown  13   may 2008
## 2536   2536  53       retired  married  tertiary      no    1691      no   no   unknown  13   may 2008
## 2537   2537  34    technician   single  tertiary      no       2     yes   no   unknown  13   may 2008
## 2538   2538  44        admin.   single   unknown      no       3     yes   no   unknown  13   may 2008
## 2539   2539  46   blue-collar  married   primary      no     399     yes   no   unknown  13   may 2008
## 2540   2540  53       retired   single secondary      no    1421     yes   no   unknown  13   may 2008
## 2541   2541  26    technician  married  tertiary      no       8     yes  yes   unknown  13   may 2008
## 2542   2542  31        admin.   single secondary      no     150     yes  yes   unknown  13   may 2008
## 2543   2543  35      services  married secondary      no    -371     yes   no   unknown  13   may 2008
## 2544   2544  43    technician  married secondary      no    1916     yes   no   unknown  13   may 2008
## 2545   2545  47   blue-collar  married   primary      no     300     yes   no   unknown  13   may 2008
## 2546   2546  37  entrepreneur divorced secondary      no     175     yes  yes   unknown  13   may 2008
## 2547   2547  57       retired  married  tertiary      no    3571      no   no   unknown  13   may 2008
## 2548   2548  41   blue-collar  married   primary      no    1135     yes   no   unknown  13   may 2008
## 2549   2549  55        admin. divorced   unknown      no     789     yes   no   unknown  13   may 2008
## 2550   2550  51        admin. divorced secondary      no    2195     yes   no   unknown  13   may 2008
## 2551   2551  27   blue-collar   single secondary      no    1311     yes   no   unknown  13   may 2008
## 2552   2552  53    management  married secondary     yes    -689     yes   no   unknown  13   may 2008
## 2553   2553  39        admin.   single secondary      no      14     yes  yes   unknown  13   may 2008
## 2554   2554  35        admin.  married secondary      no      56     yes   no   unknown  13   may 2008
## 2555   2555  28    technician   single secondary      no   26765      no   no   unknown  13   may 2008
## 2556   2556  29   blue-collar divorced   unknown      no      17     yes   no   unknown  13   may 2008
## 2557   2557  51    technician  married secondary      no     463     yes   no   unknown  13   may 2008
## 2558   2558  46        admin.   single secondary      no     751     yes   no   unknown  13   may 2008
## 2559   2559  50    unemployed  married secondary      no    3478     yes   no   unknown  13   may 2008
## 2560   2560  56  entrepreneur  married   unknown      no      88     yes   no   unknown  13   may 2008
## 2561   2561  28   blue-collar  married secondary      no      64     yes   no   unknown  13   may 2008
## 2562   2562  51    management  married  tertiary      no      36     yes   no   unknown  13   may 2008
## 2563   2563  54     housemaid  married secondary      no      42     yes   no   unknown  13   may 2008
## 2564   2564  47   blue-collar  married   primary      no     113     yes   no   unknown  13   may 2008
## 2565   2565  49 self-employed  married secondary      no     358     yes  yes   unknown  13   may 2008
## 2566   2566  46   blue-collar divorced   primary      no     274     yes   no   unknown  13   may 2008
## 2567   2567  41    management  married  tertiary      no       0     yes   no   unknown  13   may 2008
## 2568   2568  45        admin.  married secondary      no     985     yes   no   unknown  13   may 2008
## 2569   2569  31   blue-collar  married   primary      no      81     yes   no   unknown  13   may 2008
## 2570   2570  53        admin. divorced secondary      no     592     yes   no   unknown  13   may 2008
## 2571   2571  60        admin. divorced   unknown      no     791     yes   no   unknown  13   may 2008
## 2572   2572  55       retired  married secondary      no     708     yes   no   unknown  13   may 2008
## 2573   2573  54    technician divorced secondary      no      51     yes   no   unknown  13   may 2008
## 2574   2574  46   blue-collar  married   primary      no       0     yes   no   unknown  13   may 2008
## 2575   2575  41    technician   single   unknown      no     356     yes   no   unknown  13   may 2008
## 2576   2576  34        admin.  married secondary      no      34     yes   no   unknown  13   may 2008
## 2577   2577  51    technician  married secondary      no   12061     yes   no   unknown  13   may 2008
## 2578   2578  31        admin.   single secondary      no     513     yes   no   unknown  13   may 2008
## 2579   2579  55    technician  married secondary      no    6958     yes  yes   unknown  13   may 2008
## 2580   2580  44    management  married  tertiary      no     126     yes   no   unknown  13   may 2008
## 2581   2581  25      services   single secondary      no      54     yes   no   unknown  13   may 2008
## 2582   2582  36   blue-collar  married secondary      no     373     yes   no   unknown  13   may 2008
## 2583   2583  33   blue-collar  married secondary      no     304     yes   no   unknown  13   may 2008
## 2584   2584  46   blue-collar  married secondary      no     781      no   no   unknown  13   may 2008
## 2585   2585  43   blue-collar divorced   primary      no      42      no   no   unknown  13   may 2008
## 2586   2586  46    management  married  tertiary      no     618     yes   no   unknown  13   may 2008
## 2587   2587  53   blue-collar  married secondary      no    1570     yes   no   unknown  13   may 2008
## 2588   2588  52    technician divorced secondary      no    1161     yes   no   unknown  13   may 2008
## 2589   2589  57    management divorced   unknown      no       0      no   no   unknown  13   may 2008
## 2590   2590  31   blue-collar   single secondary      no    -745     yes   no   unknown  13   may 2008
## 2591   2591  54      services  married secondary      no      88     yes   no   unknown  13   may 2008
## 2592   2592  37    management  married  tertiary      no    1330     yes   no   unknown  13   may 2008
## 2593   2593  41   blue-collar  married secondary      no     641     yes   no   unknown  13   may 2008
## 2594   2594  44        admin.  married secondary      no    1423     yes   no   unknown  13   may 2008
## 2595   2595  26      services   single secondary      no    8206     yes   no   unknown  13   may 2008
## 2596   2596  40   blue-collar  married   primary      no    4436     yes   no   unknown  13   may 2008
## 2597   2597  32        admin. divorced secondary      no    1611     yes  yes   unknown  13   may 2008
## 2598   2598  44    technician   single  tertiary      no     607     yes   no   unknown  13   may 2008
## 2599   2599  44   blue-collar  married   primary      no     300     yes   no   unknown  13   may 2008
## 2600   2600  35    technician  married secondary      no     304     yes   no   unknown  13   may 2008
## 2601   2601  49      services  married secondary      no     254     yes   no   unknown  13   may 2008
## 2602   2602  44    technician  married secondary      no    3790     yes   no   unknown  13   may 2008
## 2603   2603  40   blue-collar  married secondary      no      59     yes   no   unknown  13   may 2008
## 2604   2604  39   blue-collar  married secondary      no    1554     yes   no   unknown  13   may 2008
## 2605   2605  51   blue-collar divorced  tertiary      no     257     yes   no   unknown  13   may 2008
## 2606   2606  59       retired divorced   primary      no     643     yes   no   unknown  13   may 2008
## 2607   2607  42        admin.  married secondary      no     128     yes   no   unknown  13   may 2008
## 2608   2608  47      services divorced secondary      no     743     yes  yes   unknown  13   may 2008
## 2609   2609  57   blue-collar  married   primary      no    1460      no   no   unknown  13   may 2008
## 2610   2610  42    management  married secondary      no     -32     yes   no   unknown  13   may 2008
## 2611   2611  40      services  married   primary      no    1117     yes   no   unknown  13   may 2008
## 2612   2612  44    technician  married   primary      no    2887     yes   no   unknown  13   may 2008
## 2613   2613  38        admin.   single   unknown      no     446     yes   no   unknown  13   may 2008
## 2614   2614  51    management  married  tertiary      no    1212     yes   no   unknown  13   may 2008
## 2615   2615  48    management  married  tertiary      no    2218     yes   no   unknown  13   may 2008
## 2616   2616  48   blue-collar  married secondary      no     705      no   no   unknown  13   may 2008
## 2617   2617  42   blue-collar divorced   primary      no     299     yes   no   unknown  13   may 2008
## 2618   2618  48  entrepreneur  married  tertiary      no     313     yes   no   unknown  13   may 2008
## 2619   2619  49    management  married  tertiary      no   12482     yes  yes   unknown  13   may 2008
## 2620   2620  44      services  married secondary      no   29312      no   no   unknown  13   may 2008
## 2621   2621  44      services  married   primary      no    2226     yes  yes   unknown  13   may 2008
## 2622   2622  32   blue-collar   single secondary      no    1940     yes  yes   unknown  13   may 2008
## 2623   2623  43   blue-collar  married secondary      no     576     yes  yes   unknown  13   may 2008
## 2624   2624  44      services divorced secondary      no       0     yes  yes   unknown  13   may 2008
## 2625   2625  53        admin. divorced secondary      no     887     yes   no   unknown  13   may 2008
## 2626   2626  43   blue-collar  married   primary      no      17     yes   no   unknown  13   may 2008
## 2627   2627  31    technician  married secondary      no     106     yes   no   unknown  13   may 2008
## 2628   2628  48    management  married  tertiary      no     489     yes   no   unknown  13   may 2008
## 2629   2629  46    technician   single secondary      no     148     yes   no   unknown  13   may 2008
## 2630   2630  41   blue-collar divorced secondary      no      14     yes  yes   unknown  13   may 2008
## 2631   2631  26    management  married  tertiary      no    1531     yes   no   unknown  13   may 2008
## 2632   2632  26   blue-collar  married secondary      no    3108     yes   no   unknown  13   may 2008
## 2633   2633  52        admin. divorced secondary      no      26     yes   no   unknown  13   may 2008
## 2634   2634  47   blue-collar  married   primary      no    2466     yes   no   unknown  13   may 2008
## 2635   2635  47   blue-collar  married   unknown      no    1045     yes   no   unknown  13   may 2008
## 2636   2636  27   blue-collar  married   primary     yes    -588      no   no   unknown  13   may 2008
## 2637   2637  31      services  married secondary      no     413     yes   no   unknown  13   may 2008
## 2638   2638  60       retired  married  tertiary      no       0     yes   no   unknown  13   may 2008
## 2639   2639  58       retired  married   primary      no     193     yes  yes   unknown  13   may 2008
## 2640   2640  44   blue-collar  married secondary      no    1340     yes   no   unknown  13   may 2008
## 2641   2641  32   blue-collar  married secondary      no     363     yes   no   unknown  13   may 2008
## 2642   2642  33   blue-collar  married   primary      no    -306     yes  yes   unknown  13   may 2008
## 2643   2643  38        admin.  married secondary      no     607     yes   no   unknown  13   may 2008
## 2644   2644  35    technician divorced secondary      no     556     yes   no   unknown  13   may 2008
## 2645   2645  47    technician  married secondary      no     449     yes  yes   unknown  13   may 2008
## 2646   2646  32   blue-collar   single secondary      no     338     yes   no   unknown  13   may 2008
## 2647   2647  41    management  married   primary      no      -4     yes  yes   unknown  13   may 2008
## 2648   2648  30    management   single  tertiary      no     623     yes   no   unknown  13   may 2008
## 2649   2649  60       retired  married secondary      no    1390      no  yes   unknown  13   may 2008
## 2650   2650  36   blue-collar divorced secondary      no     719     yes   no   unknown  13   may 2008
## 2651   2651  46   blue-collar  married   primary      no     369     yes   no   unknown  13   may 2008
## 2652   2652  58   blue-collar  married   primary      no    1357     yes   no   unknown  13   may 2008
## 2653   2653  52  entrepreneur  married   unknown      no       0     yes   no   unknown  13   may 2008
## 2654   2654  55    management  married secondary      no       0     yes   no   unknown  13   may 2008
## 2655   2655  43   blue-collar  married   primary      no    2047     yes   no   unknown  13   may 2008
## 2656   2656  24        admin.   single secondary      no     507     yes   no   unknown  13   may 2008
## 2657   2657  24   blue-collar  married   primary      no    -427     yes   no   unknown  13   may 2008
## 2658   2658  25   blue-collar  married secondary      no      53     yes   no   unknown  13   may 2008
## 2659   2659  40    technician  married secondary      no      93     yes   no   unknown  13   may 2008
## 2660   2660  31   blue-collar  married secondary      no     822     yes   no   unknown  13   may 2008
## 2661   2661  31    technician   single secondary      no     849     yes  yes   unknown  13   may 2008
## 2662   2662  26   blue-collar   single secondary      no    -214     yes   no   unknown  13   may 2008
## 2663   2663  52   blue-collar  married secondary      no     161     yes   no   unknown  13   may 2008
## 2664   2664  25    technician   single  tertiary      no     800     yes   no   unknown  13   may 2008
## 2665   2665  40   blue-collar  married secondary      no     598     yes   no   unknown  13   may 2008
## 2666   2666  42   blue-collar divorced secondary      no    -135     yes   no   unknown  13   may 2008
## 2667   2667  31    technician  married  tertiary      no       0     yes  yes   unknown  13   may 2008
## 2668   2668  43  entrepreneur  married secondary      no      59      no   no   unknown  13   may 2008
## 2669   2669  57   blue-collar  married   primary      no     452     yes   no   unknown  13   may 2008
## 2670   2670  30     housemaid   single secondary      no      49     yes   no   unknown  13   may 2008
## 2671   2671  23   blue-collar  married   primary      no    -213      no   no   unknown  13   may 2008
## 2672   2672  53   blue-collar divorced   primary      no    2477     yes   no   unknown  13   may 2008
## 2673   2673  44 self-employed  married secondary      no     264     yes   no   unknown  13   may 2008
## 2674   2674  48    technician  married secondary      no    4265     yes   no   unknown  13   may 2008
## 2675   2675  59       retired divorced  tertiary      no     559     yes   no   unknown  13   may 2008
## 2676   2676  33    management  married secondary      no     -15     yes   no   unknown  13   may 2008
## 2677   2677  60       retired  married secondary      no     926     yes   no   unknown  13   may 2008
## 2678   2678  42      services  married secondary      no     693     yes   no   unknown  13   may 2008
## 2679   2679  44    management   single  tertiary      no    9956     yes   no   unknown  13   may 2008
## 2680   2680  50    management   single  tertiary      no    1300     yes   no   unknown  13   may 2008
## 2681   2681  54       retired  married secondary      no    2626      no   no   unknown  13   may 2008
## 2682   2682  29        admin.   single secondary      no     -44     yes   no   unknown  13   may 2008
## 2683   2683  59 self-employed  married  tertiary      no     593      no   no   unknown  13   may 2008
## 2684   2684  37    technician  married secondary      no     511     yes   no   unknown  13   may 2008
## 2685   2685  55       retired  married secondary      no     493     yes   no   unknown  13   may 2008
## 2686   2686  53       retired divorced  tertiary      no     599     yes   no   unknown  13   may 2008
## 2687   2687  31      services  married secondary      no     272     yes   no   unknown  13   may 2008
## 2688   2688  49    management  married  tertiary      no     735     yes   no   unknown  13   may 2008
## 2689   2689  28   blue-collar  married   primary      no      15     yes   no   unknown  13   may 2008
## 2690   2690  47   blue-collar  married   primary      no     159     yes   no   unknown  13   may 2008
## 2691   2691  31   blue-collar  married   primary      no     651     yes   no   unknown  13   may 2008
## 2692   2692  49     housemaid divorced   primary      no     198     yes   no   unknown  13   may 2008
## 2693   2693  59   blue-collar  married   unknown      no    -278     yes   no   unknown  13   may 2008
## 2694   2694  34   blue-collar  married secondary      no    -100     yes   no   unknown  13   may 2008
## 2695   2695  43        admin.  married   primary      no      15     yes   no   unknown  13   may 2008
## 2696   2696  38   blue-collar  married   primary      no       0      no   no   unknown  13   may 2008
## 2697   2697  41      services  married secondary      no     108     yes  yes   unknown  13   may 2008
## 2698   2698  44   blue-collar  married   primary      no     617     yes   no   unknown  13   may 2008
## 2699   2699  31      services   single secondary      no     516     yes   no   unknown  13   may 2008
## 2700   2700  35   blue-collar  married   primary      no      11     yes   no   unknown  13   may 2008
## 2701   2701  37        admin.  married secondary      no    1026     yes   no   unknown  13   may 2008
## 2702   2702  58        admin.  married secondary      no    3635      no   no   unknown  13   may 2008
## 2703   2703  24   blue-collar  married secondary      no      32      no   no   unknown  13   may 2008
## 2704   2704  35   blue-collar   single   primary      no    -123     yes   no   unknown  13   may 2008
## 2705   2705  33   blue-collar divorced secondary      no    -238     yes   no   unknown  13   may 2008
## 2706   2706  40  entrepreneur  married  tertiary      no    1089     yes  yes   unknown  13   may 2008
## 2707   2707  46        admin. divorced  tertiary      no    3749     yes   no   unknown  13   may 2008
## 2708   2708  41   blue-collar  married   primary      no    3140     yes   no   unknown  13   may 2008
## 2709   2709  33   blue-collar  married  tertiary      no     221     yes   no   unknown  13   may 2008
## 2710   2710  35   blue-collar divorced   primary      no     300     yes   no   unknown  13   may 2008
## 2711   2711  57       retired divorced   primary      no     515     yes   no   unknown  13   may 2008
## 2712   2712  40    technician  married   primary      no     819     yes   no   unknown  13   may 2008
## 2713   2713  36   blue-collar  married secondary      no     722     yes   no   unknown  13   may 2008
## 2714   2714  47    management divorced secondary      no    3346     yes  yes   unknown  13   may 2008
## 2715   2715  50   blue-collar  married   primary      no     419     yes   no   unknown  13   may 2008
## 2716   2716  51    technician  married secondary      no     330     yes   no   unknown  13   may 2008
## 2717   2717  41    management divorced  tertiary      no    1576     yes   no   unknown  13   may 2008
## 2718   2718  38    management  married  tertiary      no     258     yes   no   unknown  13   may 2008
## 2719   2719  39   blue-collar  married   primary      no     317     yes   no   unknown  13   may 2008
## 2720   2720  25      services   single secondary     yes      57     yes  yes   unknown  13   may 2008
## 2721   2721  43    technician  married secondary      no    3285     yes   no   unknown  13   may 2008
## 2722   2722  33   blue-collar  married secondary      no     152     yes   no   unknown  13   may 2008
## 2723   2723  45   blue-collar  married secondary      no    2429     yes   no   unknown  13   may 2008
## 2724   2724  58       unknown divorced secondary      no    3111     yes   no   unknown  13   may 2008
## 2725   2725  57   blue-collar  married   primary      no    1352     yes   no   unknown  13   may 2008
## 2726   2726  27    unemployed   single  tertiary      no      37     yes   no   unknown  13   may 2008
## 2727   2727  25    technician   single  tertiary      no     640     yes   no   unknown  13   may 2008
## 2728   2728  38   blue-collar  married   unknown      no     113      no   no   unknown  13   may 2008
## 2729   2729  28    technician   single secondary      no     468     yes   no   unknown  13   may 2008
## 2730   2730  33      services  married secondary      no     184     yes   no   unknown  13   may 2008
## 2731   2731  44   blue-collar   single secondary      no     633     yes   no   unknown  13   may 2008
## 2732   2732  57        admin.  married secondary      no       7     yes   no   unknown  14   may 2008
## 2733   2733  46   blue-collar   single secondary      no      57     yes   no   unknown  14   may 2008
## 2734   2734  57    technician divorced secondary      no       0     yes   no   unknown  14   may 2008
## 2735   2735  42   blue-collar divorced   primary      no     419     yes  yes   unknown  14   may 2008
## 2736   2736  46        admin.  married secondary      no     120     yes   no   unknown  14   may 2008
## 2737   2737  39  entrepreneur  married secondary      no     580     yes   no   unknown  14   may 2008
## 2738   2738  27   blue-collar  married secondary      no     362     yes   no   unknown  14   may 2008
## 2739   2739  42    management  married secondary      no      43     yes   no   unknown  14   may 2008
## 2740   2740  58        admin.  married secondary      no     749     yes   no   unknown  14   may 2008
## 2741   2741  42        admin.   single secondary      no     243     yes   no   unknown  14   may 2008
## 2742   2742  48   blue-collar  married   primary      no    9004      no   no   unknown  14   may 2008
## 2743   2743  57      services   single secondary      no    2236     yes   no   unknown  14   may 2008
## 2744   2744  52        admin.   single secondary      no    3348     yes   no   unknown  14   may 2008
## 2745   2745  54   blue-collar divorced   primary      no    2062     yes   no   unknown  14   may 2008
## 2746   2746  55       retired  married secondary      no     188      no   no   unknown  14   may 2008
## 2747   2747  46   blue-collar  married   primary      no    1483     yes   no   unknown  14   may 2008
## 2748   2748  48  entrepreneur  married   unknown      no    2550     yes   no   unknown  14   may 2008
## 2749   2749  25        admin.   single secondary     yes      53     yes   no   unknown  14   may 2008
## 2750   2750  38    management divorced  tertiary      no     547     yes   no   unknown  14   may 2008
## 2751   2751  46       retired  married   primary      no    1374      no  yes   unknown  14   may 2008
## 2752   2752  48    technician  married   unknown      no      67     yes   no   unknown  14   may 2008
## 2753   2753  43   blue-collar  married   primary      no    4998     yes   no   unknown  14   may 2008
## 2754   2754  52    technician  married secondary      no       0      no   no   unknown  14   may 2008
## 2755   2755  27   blue-collar   single secondary     yes      -2     yes  yes   unknown  14   may 2008
## 2756   2756  29   blue-collar  married secondary      no      23     yes   no   unknown  14   may 2008
## 2757   2757  49        admin.  married secondary      no     512     yes  yes   unknown  14   may 2008
## 2758   2758  30   blue-collar   single secondary     yes     447      no   no   unknown  14   may 2008
## 2759   2759  50        admin.  married secondary      no    1917     yes   no   unknown  14   may 2008
## 2760   2760  58   blue-collar  married   unknown      no    4871     yes   no   unknown  14   may 2008
## 2761   2761  44   blue-collar  married secondary      no     326     yes   no   unknown  14   may 2008
## 2762   2762  52    technician  married secondary      no       0     yes  yes   unknown  14   may 2008
## 2763   2763  44  entrepreneur  married secondary      no       0      no   no   unknown  14   may 2008
## 2764   2764  27   blue-collar   single secondary      no      14      no   no   unknown  14   may 2008
## 2765   2765  35    technician  married secondary      no     692     yes  yes   unknown  14   may 2008
## 2766   2766  31   blue-collar  married secondary      no     369     yes  yes   unknown  14   may 2008
## 2767   2767  31   blue-collar  married   primary      no     591     yes   no   unknown  14   may 2008
## 2768   2768  52     housemaid  married secondary      no    3923     yes   no   unknown  14   may 2008
## 2769   2769  44   blue-collar  married secondary      no       0     yes   no   unknown  14   may 2008
## 2770   2770  28   blue-collar   single   primary      no     348     yes  yes   unknown  14   may 2008
## 2771   2771  41    technician  married secondary      no     102     yes  yes   unknown  14   may 2008
## 2772   2772  54    technician divorced secondary      no     447     yes   no   unknown  14   may 2008
## 2773   2773  46   blue-collar  married secondary      no    2121     yes   no   unknown  14   may 2008
## 2774   2774  48   blue-collar  married   primary      no    5154     yes   no   unknown  14   may 2008
## 2775   2775  31        admin.  married secondary      no     393     yes   no   unknown  14   may 2008
## 2776   2776  42      services  married   primary      no    5879     yes   no   unknown  14   may 2008
## 2777   2777  40   blue-collar  married secondary      no     -31     yes   no   unknown  14   may 2008
## 2778   2778  56 self-employed  married  tertiary      no     871     yes   no   unknown  14   may 2008
## 2779   2779  45    management  married  tertiary      no   37378     yes   no   unknown  14   may 2008
## 2780   2780  53    technician divorced   primary      no    1443     yes   no   unknown  14   may 2008
## 2781   2781  31        admin.  married secondary      no     752     yes   no   unknown  14   may 2008
## 2782   2782  42    management  married  tertiary      no    1093     yes   no   unknown  14   may 2008
## 2783   2783  51    technician  married   unknown      no     573     yes  yes   unknown  14   may 2008
## 2784   2784  52    management  married  tertiary      no     258      no   no   unknown  14   may 2008
## 2785   2785  48    management  married   primary      no     247     yes  yes   unknown  14   may 2008
## 2786   2786  28    management   single  tertiary      no     202     yes   no   unknown  14   may 2008
## 2787   2787  34    technician   single secondary      no     302     yes   no   unknown  14   may 2008
## 2788   2788  50        admin.  married secondary      no     736     yes   no   unknown  14   may 2008
## 2789   2789  46   blue-collar  married   primary      no       0     yes   no   unknown  14   may 2008
## 2790   2790  54   blue-collar  married secondary      no     532     yes   no   unknown  14   may 2008
## 2791   2791  43    technician divorced secondary      no       0      no   no   unknown  14   may 2008
## 2792   2792  55   blue-collar divorced secondary      no    7378      no   no   unknown  14   may 2008
## 2793   2793  47   blue-collar  married   primary      no    4666      no   no   unknown  14   may 2008
## 2794   2794  43  entrepreneur  married secondary      no    1516     yes   no   unknown  14   may 2008
## 2795   2795  45    technician  married secondary      no       0     yes  yes   unknown  14   may 2008
## 2796   2796  46   blue-collar  married secondary      no    6085     yes  yes   unknown  14   may 2008
## 2797   2797  39    technician  married secondary     yes    -183     yes   no   unknown  14   may 2008
## 2798   2798  26       student   single secondary      no      91     yes   no   unknown  14   may 2008
## 2799   2799  40   blue-collar  married secondary      no      30     yes   no   unknown  14   may 2008
## 2800   2800  48   blue-collar divorced   primary      no      24     yes   no   unknown  14   may 2008
## 2801   2801  53    technician divorced secondary      no     522     yes   no   unknown  14   may 2008
## 2802   2802  40    technician  married secondary      no     770     yes   no   unknown  14   may 2008
## 2803   2803  54   blue-collar  married secondary      no    1288     yes   no   unknown  14   may 2008
## 2804   2804  46    technician  married secondary      no    1029     yes   no   unknown  14   may 2008
## 2805   2805  47    technician divorced secondary      no    4135     yes   no   unknown  14   may 2008
## 2806   2806  50   blue-collar divorced secondary      no     204     yes  yes   unknown  14   may 2008
## 2807   2807  59       retired divorced   primary      no    1534     yes   no   unknown  14   may 2008
## 2808   2808  44      services   single secondary      no       0     yes   no   unknown  14   may 2008
## 2809   2809  42    management  married  tertiary      no     877     yes   no   unknown  14   may 2008
## 2810   2810  52    management  married secondary      no     478     yes   no   unknown  14   may 2008
## 2811   2811  30    management   single  tertiary      no    1130     yes   no   unknown  14   may 2008
## 2812   2812  46   blue-collar   single secondary      no    2401     yes   no   unknown  14   may 2008
## 2813   2813  45    management  married  tertiary      no     740     yes   no   unknown  14   may 2008
## 2814   2814  29        admin.   single secondary      no     993      no   no   unknown  14   may 2008
## 2815   2815  53   blue-collar  married   primary      no     896     yes   no   unknown  14   may 2008
## 2816   2816  55        admin.  married secondary      no     332     yes   no   unknown  14   may 2008
## 2817   2817  45    management   single  tertiary      no    1088      no   no   unknown  14   may 2008
## 2818   2818  35    technician  married secondary      no      51     yes   no   unknown  14   may 2008
## 2819   2819  52   blue-collar   single secondary      no    1541     yes   no   unknown  14   may 2008
## 2820   2820  40    management  married  tertiary      no     413     yes   no   unknown  14   may 2008
## 2821   2821  42        admin.  married secondary      no    2656     yes   no   unknown  14   may 2008
## 2822   2822  41   blue-collar   single   primary      no    1618     yes   no   unknown  14   may 2008
## 2823   2823  42        admin. divorced secondary      no     146     yes   no   unknown  14   may 2008
## 2824   2824  40        admin.  married secondary      no     153     yes   no   unknown  14   may 2008
## 2825   2825  41      services  married secondary      no    4505     yes   no   unknown  14   may 2008
## 2826   2826  57    management  married  tertiary      no       0     yes   no   unknown  14   may 2008
## 2827   2827  45        admin.  married secondary      no     520     yes   no   unknown  14   may 2008
## 2828   2828  47    management  married   primary      no    4151     yes   no   unknown  14   may 2008
## 2829   2829  40    unemployed  married secondary      no    3382     yes   no   unknown  14   may 2008
## 2830   2830  33    technician   single secondary      no     261     yes   no   unknown  14   may 2008
## 2831   2831  49  entrepreneur  married secondary      no    1160     yes   no   unknown  14   may 2008
## 2832   2832  39    management divorced  tertiary      no     517     yes  yes   unknown  14   may 2008
## 2833   2833  50      services  married secondary      no    2956     yes   no   unknown  14   may 2008
## 2834   2834  60       retired divorced   primary      no    1327     yes  yes   unknown  14   may 2008
## 2835   2835  53    technician  married secondary      no    8417     yes   no   unknown  14   may 2008
## 2836   2836  58       retired  married secondary      no    -172     yes   no   unknown  14   may 2008
## 2837   2837  52      services  married secondary      no    2257     yes   no   unknown  14   may 2008
## 2838   2838  42        admin.   single secondary      no     277     yes   no   unknown  14   may 2008
## 2839   2839  42   blue-collar  married secondary      no     902     yes   no   unknown  14   may 2008
## 2840   2840  43    technician  married secondary      no     212     yes   no   unknown  14   may 2008
## 2841   2841  51        admin.  married secondary      no     513     yes   no   unknown  14   may 2008
## 2842   2842  53       unknown divorced  tertiary      no    2272     yes   no   unknown  14   may 2008
## 2843   2843  53    technician  married secondary      no     719     yes   no   unknown  14   may 2008
## 2844   2844  42    management  married  tertiary      no       1      no   no   unknown  14   may 2008
## 2845   2845  40    technician  married secondary      no     503     yes   no   unknown  14   may 2008
## 2846   2846  59       retired  married secondary      no    1521     yes  yes   unknown  14   may 2008
## 2847   2847  59       retired  married secondary      no    2516     yes  yes   unknown  14   may 2008
## 2848   2848  48     housemaid  married  tertiary      no     468     yes   no   unknown  14   may 2008
## 2849   2849  25       unknown   single   unknown      no     329     yes   no   unknown  14   may 2008
## 2850   2850  59   blue-collar  married   primary      no     259     yes  yes   unknown  14   may 2008
## 2851   2851  49    unemployed  married secondary      no     769     yes   no   unknown  14   may 2008
## 2852   2852  42    management  married  tertiary      no    -700     yes   no   unknown  14   may 2008
## 2853   2853  37   blue-collar  married secondary      no   15801     yes   no   unknown  14   may 2008
## 2854   2854  40   blue-collar  married   primary      no    7831     yes   no   unknown  14   may 2008
## 2855   2855  31    management  married  tertiary      no       0      no   no   unknown  14   may 2008
## 2856   2856  41   blue-collar  married secondary      no     -68     yes   no   unknown  14   may 2008
## 2857   2857  60    technician  married secondary      no    2639     yes   no   unknown  14   may 2008
## 2858   2858  42        admin. divorced secondary      no    1076     yes   no   unknown  14   may 2008
## 2859   2859  48   blue-collar  married   primary      no     584     yes   no   unknown  14   may 2008
## 2860   2860  43   blue-collar  married secondary      no    2706     yes  yes   unknown  14   may 2008
## 2861   2861  47   blue-collar  married   primary      no    1294     yes   no   unknown  14   may 2008
## 2862   2862  40 self-employed  married   primary      no     771     yes   no   unknown  14   may 2008
## 2863   2863  55    unemployed divorced secondary      no     283     yes  yes   unknown  14   may 2008
## 2864   2864  51    management divorced  tertiary      no     482     yes   no   unknown  14   may 2008
## 2865   2865  54    management  married  tertiary      no      11      no   no   unknown  14   may 2008
## 2866   2866  41   blue-collar  married secondary      no    2823     yes   no   unknown  14   may 2008
## 2867   2867  41   blue-collar  married secondary      no     338     yes   no   unknown  14   may 2008
## 2868   2868  53   blue-collar  married secondary      no    5700     yes   no   unknown  14   may 2008
## 2869   2869  46        admin.  married secondary      no    3028     yes  yes   unknown  14   may 2008
## 2870   2870  45  entrepreneur  married   primary      no    2418     yes   no   unknown  14   may 2008
## 2871   2871  48   blue-collar  married secondary      no    1405     yes   no   unknown  14   may 2008
## 2872   2872  44      services   single secondary      no       0     yes   no   unknown  14   may 2008
## 2873   2873  47   blue-collar  married secondary      no    2775      no   no   unknown  14   may 2008
## 2874   2874  49   blue-collar  married secondary      no     611     yes  yes   unknown  14   may 2008
## 2875   2875  41   blue-collar  married   primary      no    1654     yes   no   unknown  14   may 2008
## 2876   2876  54   blue-collar  married   primary      no    1691     yes   no   unknown  14   may 2008
## 2877   2877  48    technician  married secondary      no     427      no   no   unknown  14   may 2008
## 2878   2878  30   blue-collar  married secondary      no     938     yes   no   unknown  14   may 2008
## 2879   2879  45   blue-collar  married   primary      no     626     yes   no   unknown  14   may 2008
## 2880   2880  40   blue-collar  married   unknown      no     874      no   no   unknown  14   may 2008
## 2881   2881  42   blue-collar   single secondary      no      24      no   no   unknown  14   may 2008
## 2882   2882  48    technician  married secondary      no    7373     yes   no   unknown  14   may 2008
## 2883   2883  40        admin.  married secondary      no    1535     yes   no   unknown  14   may 2008
## 2884   2884  47   blue-collar  married   primary      no       2     yes  yes   unknown  14   may 2008
## 2885   2885  47        admin.  married secondary      no     829     yes  yes   unknown  14   may 2008
## 2886   2886  33   blue-collar   single secondary      no     164     yes   no   unknown  14   may 2008
## 2887   2887  54   blue-collar  married secondary      no    1765     yes   no   unknown  14   may 2008
## 2888   2888  46   blue-collar  married secondary      no    1733     yes   no   unknown  14   may 2008
## 2889   2889  53       retired  married   primary      no     383     yes   no   unknown  14   may 2008
## 2890   2890  25    technician   single  tertiary      no     777     yes   no   unknown  14   may 2008
## 2891   2891  50    management  married secondary      no       0     yes   no   unknown  14   may 2008
## 2892   2892  40   blue-collar  married secondary      no    1522     yes  yes   unknown  14   may 2008
## 2893   2893  53    management  married  tertiary      no    4446     yes   no   unknown  14   may 2008
## 2894   2894  41   blue-collar  married secondary      no     923     yes   no   unknown  14   may 2008
## 2895   2895  41        admin.  married secondary      no    1309     yes   no   unknown  14   may 2008
## 2896   2896  42    management  married  tertiary      no    1340     yes   no   unknown  14   may 2008
## 2897   2897  47    management  married  tertiary      no    3158     yes   no   unknown  14   may 2008
## 2898   2898  48   blue-collar  married secondary      no    1596     yes   no   unknown  14   may 2008
## 2899   2899  43   blue-collar  married   primary      no     887     yes   no   unknown  14   may 2008
## 2900   2900  55    management  married  tertiary      no   23189     yes   no   unknown  14   may 2008
## 2901   2901  40        admin.  married secondary      no    1010     yes   no   unknown  14   may 2008
## 2902   2902  45   blue-collar  married   primary      no     246     yes   no   unknown  14   may 2008
## 2903   2903  54       retired  married secondary      no     918     yes   no   unknown  14   may 2008
## 2904   2904  46   blue-collar  married   primary      no    1429     yes   no   unknown  14   may 2008
## 2905   2905  57       retired divorced   primary      no    2439     yes   no   unknown  14   may 2008
## 2906   2906  49  entrepreneur  married secondary      no     348     yes   no   unknown  14   may 2008
## 2907   2907  49        admin.  married secondary      no     387     yes   no   unknown  14   may 2008
## 2908   2908  41   blue-collar   single   primary      no      22     yes   no   unknown  14   may 2008
## 2909   2909  42 self-employed  married   primary      no    3641     yes   no   unknown  14   may 2008
## 2910   2910  42    management   single secondary      no    2535     yes   no   unknown  14   may 2008
## 2911   2911  49    technician  married   primary      no    1878     yes   no   unknown  14   may 2008
## 2912   2912  42   blue-collar  married secondary      no       3     yes   no   unknown  14   may 2008
## 2913   2913  34    unemployed   single secondary      no       9     yes   no   unknown  14   may 2008
## 2914   2914  47   blue-collar  married   primary      no     502     yes   no   unknown  14   may 2008
## 2915   2915  41        admin.  married secondary      no    3634     yes   no   unknown  14   may 2008
## 2916   2916  45    technician  married secondary      no    3395     yes   no   unknown  14   may 2008
## 2917   2917  33        admin.   single secondary      no     673     yes   no   unknown  14   may 2008
## 2918   2918  53   blue-collar  married   primary      no     600     yes   no   unknown  14   may 2008
## 2919   2919  43    unemployed   single   primary      no     698     yes   no   unknown  14   may 2008
## 2920   2920  40   blue-collar divorced secondary      no    2540     yes   no   unknown  14   may 2008
## 2921   2921  34   blue-collar  married   primary      no     357     yes   no   unknown  14   may 2008
## 2922   2922  40    technician  married secondary      no     782     yes   no   unknown  14   may 2008
## 2923   2923  41   blue-collar  married   primary      no    2097     yes   no   unknown  14   may 2008
## 2924   2924  44   blue-collar   single   unknown      no    -101     yes   no   unknown  14   may 2008
## 2925   2925  57        admin. divorced   primary      no     628     yes  yes   unknown  14   may 2008
## 2926   2926  42    technician  married secondary      no       0     yes   no   unknown  14   may 2008
## 2927   2927  57      services  married secondary      no    6874     yes   no   unknown  14   may 2008
## 2928   2928  43   blue-collar divorced secondary      no      16     yes   no   unknown  14   may 2008
## 2929   2929  45   blue-collar  married   primary      no    1691     yes   no   unknown  14   may 2008
## 2930   2930  60       retired  married   primary      no    1542     yes   no   unknown  14   may 2008
## 2931   2931  41   blue-collar  married   unknown      no    1057     yes   no   unknown  14   may 2008
## 2932   2932  49   blue-collar  married   primary      no   11317     yes   no   unknown  14   may 2008
## 2933   2933  42        admin.  married secondary     yes   -1300      no   no   unknown  14   may 2008
## 2934   2934  41      services  married   primary      no     299     yes   no   unknown  14   may 2008
## 2935   2935  33    technician   single secondary      no     189     yes   no   unknown  14   may 2008
## 2936   2936  56   blue-collar  married secondary      no    1412     yes   no   unknown  14   may 2008
## 2937   2937  49   blue-collar  married   primary      no       0     yes   no   unknown  14   may 2008
## 2938   2938  41   blue-collar  married secondary      no     235     yes   no   unknown  14   may 2008
## 2939   2939  48    management  married  tertiary      no   20718     yes   no   unknown  14   may 2008
## 2940   2940  41    technician  married secondary      no    1043     yes  yes   unknown  14   may 2008
## 2941   2941  41      services  married secondary      no     890     yes   no   unknown  14   may 2008
## 2942   2942  30    technician   single secondary      no     768      no  yes   unknown  14   may 2008
## 2943   2943  52  entrepreneur  married  tertiary      no     618     yes  yes   unknown  14   may 2008
## 2944   2944  40   blue-collar  married secondary      no    1313      no   no   unknown  14   may 2008
## 2945   2945  60       retired  married secondary      no    3932     yes   no   unknown  14   may 2008
## 2946   2946  28    management   single  tertiary      no     334     yes   no   unknown  14   may 2008
## 2947   2947  44 self-employed divorced secondary      no      80     yes  yes   unknown  14   may 2008
## 2948   2948  44    technician   single secondary      no     -27     yes  yes   unknown  14   may 2008
## 2949   2949  32   blue-collar   single secondary      no    2285     yes   no   unknown  14   may 2008
## 2950   2950  53    management  married  tertiary      no     193      no   no   unknown  14   may 2008
## 2951   2951  41      services divorced secondary     yes    -198      no  yes   unknown  14   may 2008
## 2952   2952  57       retired  married  tertiary      no    1180     yes  yes   unknown  14   may 2008
## 2953   2953  42   blue-collar  married   primary      no     505     yes   no   unknown  14   may 2008
## 2954   2954  31    management  married secondary      no    6943     yes   no   unknown  14   may 2008
## 2955   2955  46   blue-collar  married secondary      no     243     yes  yes   unknown  14   may 2008
## 2956   2956  40    technician   single   unknown      no    3652     yes   no   unknown  14   may 2008
## 2957   2957  46    technician divorced secondary      no    3455     yes   no   unknown  14   may 2008
## 2958   2958  55 self-employed   single secondary      no    2607     yes   no   unknown  14   may 2008
## 2959   2959  52   blue-collar   single   primary      no    2024     yes   no   unknown  14   may 2008
## 2960   2960  50    management  married secondary      no       0     yes   no   unknown  14   may 2008
## 2961   2961  57       retired  married secondary      no    -222      no   no   unknown  14   may 2008
## 2962   2962  28   blue-collar  married secondary      no    1238     yes   no   unknown  14   may 2008
## 2963   2963  46   blue-collar  married secondary      no      33     yes   no   unknown  14   may 2008
## 2964   2964  40        admin. divorced secondary      no    1000     yes   no   unknown  14   may 2008
## 2965   2965  56   blue-collar  married secondary      no     881     yes   no   unknown  14   may 2008
## 2966   2966  48      services divorced secondary      no     403     yes   no   unknown  14   may 2008
## 2967   2967  36    management   single  tertiary      no     -38     yes   no   unknown  14   may 2008
## 2968   2968  37    technician  married  tertiary     yes       0     yes   no   unknown  14   may 2008
## 2969   2969  41  entrepreneur  married  tertiary      no     221     yes   no   unknown  14   may 2008
## 2970   2970  43   blue-collar  married secondary      no    1109     yes   no   unknown  14   may 2008
## 2971   2971  40  entrepreneur  married secondary      no    1416     yes   no   unknown  14   may 2008
## 2972   2972  40  entrepreneur  married secondary      no     264     yes   no   unknown  14   may 2008
## 2973   2973  45   blue-collar  married secondary      no     141     yes  yes   unknown  14   may 2008
## 2974   2974  44   blue-collar  married secondary      no    1944     yes   no   unknown  14   may 2008
## 2975   2975  53  entrepreneur  married   primary      no     694     yes   no   unknown  14   may 2008
## 2976   2976  31    management  married  tertiary      no     303     yes   no   unknown  14   may 2008
## 2977   2977  50   blue-collar  married secondary      no    2087     yes   no   unknown  14   may 2008
## 2978   2978  53    management  married  tertiary      no     369     yes  yes   unknown  14   may 2008
## 2979   2979  56   blue-collar divorced secondary      no     166     yes   no   unknown  14   may 2008
## 2980   2980  45    technician  married   primary      no     718     yes   no   unknown  14   may 2008
## 2981   2981  47 self-employed  married  tertiary      no    4543     yes   no   unknown  14   may 2008
## 2982   2982  33        admin.   single secondary      no    1613     yes   no   unknown  14   may 2008
## 2983   2983  57    technician  married  tertiary      no      -1      no   no   unknown  14   may 2008
## 2984   2984  45  entrepreneur   single  tertiary      no    1410     yes   no   unknown  14   may 2008
## 2985   2985  34   blue-collar  married secondary      no     577      no   no   unknown  14   may 2008
## 2986   2986  49  entrepreneur  married   primary      no     -63     yes   no   unknown  14   may 2008
## 2987   2987  49      services  married secondary      no     892      no   no   unknown  14   may 2008
## 2988   2988  37        admin. divorced secondary      no    -113     yes   no   unknown  14   may 2008
## 2989   2989  57    technician  married secondary      no    3240     yes   no   unknown  14   may 2008
## 2990   2990  40   blue-collar  married   primary      no    3658     yes   no   unknown  14   may 2008
## 2991   2991  57       retired  married secondary      no    3545     yes   no   unknown  14   may 2008
## 2992   2992  45    unemployed  married   primary      no    1292     yes   no   unknown  14   may 2008
## 2993   2993  61       retired  married secondary      no    4248     yes   no   unknown  14   may 2008
## 2994   2994  54    management divorced secondary      no     155     yes   no   unknown  14   may 2008
## 2995   2995  46   blue-collar  married   primary      no     501     yes   no   unknown  14   may 2008
## 2996   2996  51        admin.  married   primary      no     658     yes   no   unknown  14   may 2008
## 2997   2997  42   blue-collar  married secondary      no    3743     yes   no   unknown  14   may 2008
## 2998   2998  42   blue-collar  married   primary      no     329     yes   no   unknown  14   may 2008
## 2999   2999  60    management  married   primary      no     703     yes   no   unknown  14   may 2008
## 3000   3000  41   blue-collar  married   primary      no    7735     yes   no   unknown  14   may 2008
## 3001   3001  41      services  married   primary      no     455     yes   no   unknown  14   may 2008
## 3002   3002  55   blue-collar  married secondary      no     831     yes   no   unknown  14   may 2008
## 3003   3003  46      services  married secondary      no    1757     yes   no   unknown  14   may 2008
## 3004   3004  54   blue-collar  married secondary      no    1480     yes   no   unknown  14   may 2008
## 3005   3005  51   blue-collar  married secondary      no    7180     yes   no   unknown  14   may 2008
## 3006   3006  47      services divorced secondary      no    4906     yes   no   unknown  14   may 2008
## 3007   3007  35    management   single  tertiary      no     592      no  yes   unknown  14   may 2008
## 3008   3008  30   blue-collar  married secondary      no     128     yes   no   unknown  14   may 2008
## 3009   3009  32    management   single secondary      no     160     yes   no   unknown  14   may 2008
## 3010   3010  35   blue-collar  married   primary      no     441     yes   no   unknown  14   may 2008
## 3011   3011  48   blue-collar   single secondary      no    8982     yes   no   unknown  14   may 2008
## 3012   3012  36      services  married secondary      no     338      no   no   unknown  14   may 2008
## 3013   3013  53      services  married secondary      no   10749     yes   no   unknown  14   may 2008
## 3014   3014  48    technician  married secondary      no     638     yes   no   unknown  14   may 2008
## 3015   3015  42      services  married secondary      no     737     yes   no   unknown  14   may 2008
## 3016   3016  38      services   single secondary      no    7695     yes   no   unknown  14   may 2008
## 3017   3017  32        admin.   single secondary      no      91     yes   no   unknown  14   may 2008
## 3018   3018  51    unemployed  married secondary      no     760     yes   no   unknown  14   may 2008
## 3019   3019  34   blue-collar  married secondary      no     683     yes   no   unknown  14   may 2008
## 3020   3020  43   blue-collar  married secondary      no    1311     yes   no   unknown  14   may 2008
## 3021   3021  50   blue-collar  married secondary      no     606     yes   no   unknown  14   may 2008
## 3022   3022  44   blue-collar  married   primary      no       0     yes   no   unknown  14   may 2008
## 3023   3023  25      services   single secondary      no     192     yes   no   unknown  14   may 2008
## 3024   3024  60   blue-collar  married secondary      no     751     yes   no   unknown  14   may 2008
## 3025   3025  32    technician   single   unknown      no   10600      no   no   unknown  14   may 2008
## 3026   3026  44        admin.  married secondary      no     447     yes  yes   unknown  14   may 2008
## 3027   3027  26       student   single secondary      no    3096     yes   no   unknown  14   may 2008
## 3028   3028  36        admin.  married secondary      no     998     yes   no   unknown  14   may 2008
## 3029   3029  29  entrepreneur   single  tertiary      no     303     yes   no   unknown  14   may 2008
## 3030   3030  29    management   single  tertiary      no    1952     yes   no   unknown  14   may 2008
## 3031   3031  42   blue-collar  married secondary      no     171     yes   no   unknown  14   may 2008
## 3032   3032  32   blue-collar   single secondary      no     116      no   no   unknown  14   may 2008
## 3033   3033  37        admin.  married secondary      no     766     yes   no   unknown  14   may 2008
## 3034   3034  50        admin. divorced secondary     yes    -500     yes   no   unknown  14   may 2008
## 3035   3035  44   blue-collar  married secondary      no    2017     yes   no   unknown  14   may 2008
## 3036   3036  43    technician  married secondary      no     672     yes   no   unknown  14   may 2008
## 3037   3037  41      services  married   primary      no     450     yes   no   unknown  14   may 2008
## 3038   3038  45        admin.  married secondary      no     -31     yes   no   unknown  14   may 2008
## 3039   3039  41        admin.  married  tertiary      no    5426     yes   no   unknown  14   may 2008
## 3040   3040  57    technician  married secondary      no     629     yes   no   unknown  14   may 2008
## 3041   3041  34 self-employed   single  tertiary      no    2800     yes   no   unknown  14   may 2008
## 3042   3042  47      services  married secondary      no    1549     yes   no   unknown  14   may 2008
## 3043   3043  49    technician  married secondary      no    6050     yes   no   unknown  14   may 2008
## 3044   3044  58   blue-collar  married   primary      no    1406     yes   no   unknown  14   may 2008
## 3045   3045  51    unemployed  married secondary      no     425     yes   no   unknown  14   may 2008
## 3046   3046  30    management  married  tertiary      no    -328     yes   no   unknown  14   may 2008
## 3047   3047  47      services divorced secondary      no     430     yes  yes   unknown  14   may 2008
## 3048   3048  29    technician   single secondary      no    6911      no   no   unknown  14   may 2008
## 3049   3049  51   blue-collar  married   primary      no     111     yes   no   unknown  14   may 2008
## 3050   3050  49     housemaid   single   primary      no    1158     yes   no   unknown  14   may 2008
## 3051   3051  43      services  married secondary      no     823     yes   no   unknown  14   may 2008
## 3052   3052  41   blue-collar  married   primary      no     410     yes   no   unknown  14   may 2008
## 3053   3053  29        admin.   single secondary      no    1028     yes   no   unknown  14   may 2008
## 3054   3054  42   blue-collar  married   primary      no    1288     yes   no   unknown  14   may 2008
## 3055   3055  34   blue-collar   single secondary     yes    -115     yes   no   unknown  14   may 2008
## 3056   3056  44    management  married  tertiary      no     474     yes  yes   unknown  14   may 2008
## 3057   3057  44      services divorced secondary      no    2416     yes   no   unknown  14   may 2008
## 3058   3058  30    management  married  tertiary      no     233     yes   no   unknown  14   may 2008
## 3059   3059  26   blue-collar   single secondary      no     277      no   no   unknown  14   may 2008
## 3060   3060  28    technician   single secondary      no     280     yes   no   unknown  14   may 2008
## 3061   3061  42    technician  married  tertiary      no    2106     yes  yes   unknown  14   may 2008
## 3062   3062  40     housemaid divorced   primary      no    2610     yes   no   unknown  14   may 2008
## 3063   3063  49       retired  married secondary      no     329     yes   no   unknown  14   may 2008
## 3064   3064  42        admin. divorced secondary      no    1811     yes   no   unknown  14   may 2008
## 3065   3065  29        admin.  married secondary      no     387     yes  yes   unknown  14   may 2008
## 3066   3066  47   blue-collar  married   primary      no    6439     yes   no   unknown  14   may 2008
## 3067   3067  42    management  married   unknown      no    1333     yes   no   unknown  14   may 2008
## 3068   3068  45      services divorced secondary      no     864     yes   no   unknown  14   may 2008
## 3069   3069  29        admin.   single secondary      no     900     yes   no   unknown  14   may 2008
## 3070   3070  41    technician  married  tertiary      no     744     yes   no   unknown  14   may 2008
## 3071   3071  40   blue-collar   single   unknown      no    4370     yes   no   unknown  14   may 2008
## 3072   3072  48        admin.  married secondary      no    6532     yes   no   unknown  14   may 2008
## 3073   3073  41   blue-collar  married   primary      no     348     yes   no   unknown  14   may 2008
## 3074   3074  60       retired  married secondary      no    2077     yes   no   unknown  14   may 2008
## 3075   3075  44    management  married  tertiary      no    1945      no   no   unknown  14   may 2008
## 3076   3076  49 self-employed   single  tertiary      no      21     yes   no   unknown  14   may 2008
## 3077   3077  47    management divorced  tertiary      no    4556     yes   no   unknown  14   may 2008
## 3078   3078  48    technician  married secondary      no    1764     yes   no   unknown  14   may 2008
## 3079   3079  44        admin.  married   primary      no     248     yes   no   unknown  14   may 2008
## 3080   3080  28   blue-collar  married   primary      no       0      no   no   unknown  14   may 2008
## 3081   3081  31      services  married secondary      no      37     yes   no   unknown  14   may 2008
## 3082   3082  29   blue-collar  married   primary      no     236     yes   no   unknown  14   may 2008
## 3083   3083  28       student   single secondary      no     246     yes   no   unknown  14   may 2008
## 3084   3084  43      services divorced secondary      no     206     yes   no   unknown  14   may 2008
## 3085   3085  32      services  married secondary      no     162     yes   no   unknown  14   may 2008
## 3086   3086  44    technician divorced secondary      no     976     yes   no   unknown  14   may 2008
## 3087   3087  42    technician  married secondary      no     645     yes  yes   unknown  14   may 2008
## 3088   3088  45   blue-collar  married   primary      no    1794     yes   no   unknown  14   may 2008
## 3089   3089  31        admin.   single secondary      no     358     yes   no   unknown  14   may 2008
## 3090   3090  48    technician   single secondary      no    9131     yes   no   unknown  14   may 2008
## 3091   3091  45   blue-collar  married   primary      no     532     yes   no   unknown  14   may 2008
## 3092   3092  27   blue-collar   single secondary      no    1150     yes   no   unknown  14   may 2008
## 3093   3093  55   blue-collar  married   primary      no     680     yes   no   unknown  14   may 2008
## 3094   3094  45  entrepreneur  married secondary      no     245     yes   no   unknown  14   may 2008
## 3095   3095  50    unemployed  married secondary      no     -13     yes   no   unknown  14   may 2008
## 3096   3096  44    unemployed  married secondary      no     728     yes   no   unknown  14   may 2008
## 3097   3097  45        admin.  married secondary      no     137     yes   no   unknown  14   may 2008
## 3098   3098  51     housemaid  married   primary      no     289      no   no   unknown  14   may 2008
## 3099   3099  30   blue-collar   single secondary      no     609     yes   no   unknown  14   may 2008
## 3100   3100  43   blue-collar  married secondary      no   15740     yes   no   unknown  14   may 2008
## 3101   3101  41   blue-collar  married   primary      no     574     yes   no   unknown  14   may 2008
## 3102   3102  30   blue-collar  married   primary      no    1480     yes   no   unknown  14   may 2008
## 3103   3103  41   blue-collar  married secondary      no     343     yes   no   unknown  14   may 2008
## 3104   3104  29   blue-collar  married secondary      no     424     yes  yes   unknown  14   may 2008
## 3105   3105  31        admin.  married secondary      no     413     yes   no   unknown  14   may 2008
## 3106   3106  40    technician   single secondary      no     277     yes   no   unknown  14   may 2008
## 3107   3107  41   blue-collar  married secondary      no    2157     yes   no   unknown  14   may 2008
## 3108   3108  43        admin. divorced secondary      no     738     yes   no   unknown  14   may 2008
## 3109   3109  43   blue-collar  married   primary      no    -101     yes   no   unknown  14   may 2008
## 3110   3110  50  entrepreneur  married  tertiary      no     -52     yes   no   unknown  14   may 2008
## 3111   3111  40    unemployed divorced secondary      no     262     yes   no   unknown  14   may 2008
## 3112   3112  23   blue-collar   single secondary      no     -95     yes   no   unknown  14   may 2008
## 3113   3113  37        admin.  married secondary      no      66     yes   no   unknown  14   may 2008
## 3114   3114  47   blue-collar  married secondary      no    3630     yes   no   unknown  14   may 2008
## 3115   3115  29   blue-collar  married secondary      no     294     yes   no   unknown  14   may 2008
## 3116   3116  46    technician  married secondary      no    1465     yes   no   unknown  14   may 2008
## 3117   3117  31        admin.  married secondary      no       0     yes   no   unknown  14   may 2008
## 3118   3118  57    technician   single secondary      no    5961     yes   no   unknown  14   may 2008
## 3119   3119  54   blue-collar  married secondary      no    1487     yes   no   unknown  14   may 2008
## 3120   3120  44   blue-collar  married   primary      no    -295     yes   no   unknown  14   may 2008
## 3121   3121  36   blue-collar  married secondary      no       0      no   no   unknown  14   may 2008
## 3122   3122  54   blue-collar  married secondary      no     219     yes   no   unknown  14   may 2008
## 3123   3123  38    technician  married secondary      no    1442     yes  yes   unknown  14   may 2008
## 3124   3124  38   blue-collar  married secondary      no     360     yes   no   unknown  14   may 2008
## 3125   3125  40   blue-collar  married secondary      no     339     yes   no   unknown  14   may 2008
## 3126   3126  46    technician  married secondary      no    1427     yes   no   unknown  14   may 2008
## 3127   3127  41        admin.   single secondary      no      30     yes   no   unknown  14   may 2008
## 3128   3128  33    management  married  tertiary      no     483     yes   no   unknown  14   may 2008
## 3129   3129  36        admin.  married secondary      no     402     yes   no   unknown  14   may 2008
## 3130   3130  59       retired  married secondary      no    5678     yes   no   unknown  14   may 2008
## 3131   3131  49   blue-collar  married   primary      no       0      no   no   unknown  14   may 2008
## 3132   3132  49   blue-collar  married secondary      no    2631     yes   no   unknown  14   may 2008
## 3133   3133  44   blue-collar  married   primary      no     112     yes   no   unknown  14   may 2008
## 3134   3134  38        admin.  married secondary      no     664     yes   no   unknown  14   may 2008
## 3135   3135  44    technician  married secondary      no    2626     yes   no   unknown  14   may 2008
## 3136   3136  43    technician   single secondary      no      28     yes   no   unknown  14   may 2008
## 3137   3137  42   blue-collar  married   primary      no     321     yes   no   unknown  14   may 2008
## 3138   3138  41        admin.  married secondary      no    1794     yes   no   unknown  14   may 2008
## 3139   3139  52      services  married secondary      no     989     yes   no   unknown  14   may 2008
## 3140   3140  41    technician   single  tertiary      no    6029     yes   no   unknown  14   may 2008
## 3141   3141  29   blue-collar  married secondary      no     416     yes   no   unknown  14   may 2008
## 3142   3142  36   blue-collar  married   unknown      no    -389     yes   no   unknown  14   may 2008
## 3143   3143  42   blue-collar  married   unknown      no    1260     yes   no   unknown  14   may 2008
## 3144   3144  34    management  married  tertiary      no      82      no   no   unknown  14   may 2008
## 3145   3145  35    technician  married secondary      no      94     yes  yes   unknown  14   may 2008
## 3146   3146  41   blue-collar divorced secondary      no    5291     yes   no   unknown  14   may 2008
## 3147   3147  57       retired  married   primary      no    3401     yes   no   unknown  14   may 2008
## 3148   3148  46 self-employed  married secondary      no       0     yes  yes   unknown  14   may 2008
## 3149   3149  58        admin.  married secondary      no   -1196     yes  yes   unknown  14   may 2008
## 3150   3150  50   blue-collar  married secondary      no     810     yes   no   unknown  14   may 2008
## 3151   3151  57    technician divorced secondary      no    3105     yes   no   unknown  14   may 2008
## 3152   3152  47    technician  married secondary      no     351     yes   no   unknown  14   may 2008
## 3153   3153  46   blue-collar   single secondary      no    2612     yes   no   unknown  14   may 2008
## 3154   3154  47   blue-collar divorced   primary      no     556     yes   no   unknown  14   may 2008
## 3155   3155  49   blue-collar divorced   primary      no     380     yes   no   unknown  14   may 2008
## 3156   3156  49   blue-collar  married   primary      no     953     yes   no   unknown  14   may 2008
## 3157   3157  26   blue-collar   single secondary      no     786     yes  yes   unknown  14   may 2008
## 3158   3158  52    management  married  tertiary      no     601     yes   no   unknown  14   may 2008
## 3159   3159  47    management  married secondary      no     651     yes   no   unknown  14   may 2008
## 3160   3160  43    technician   single secondary      no       0     yes   no   unknown  14   may 2008
## 3161   3161  20       student   single  tertiary      no      79     yes   no   unknown  14   may 2008
## 3162   3162  43      services  married secondary      no       0     yes   no   unknown  14   may 2008
## 3163   3163  53        admin.  married secondary      no    4464     yes   no   unknown  14   may 2008
## 3164   3164  40 self-employed  married   primary      no     422     yes   no   unknown  14   may 2008
## 3165   3165  52    technician  married secondary      no     598      no   no   unknown  14   may 2008
## 3166   3166  43    technician divorced  tertiary      no     123      no   no   unknown  14   may 2008
## 3167   3167  55    management  married  tertiary      no       0     yes   no   unknown  14   may 2008
## 3168   3168  41  entrepreneur  married secondary      no     718     yes   no   unknown  14   may 2008
## 3169   3169  36   blue-collar  married secondary      no    -406     yes  yes   unknown  14   may 2008
## 3170   3170  57    management divorced secondary      no    3625     yes   no   unknown  14   may 2008
## 3171   3171  30        admin.   single secondary     yes     -35     yes   no   unknown  14   may 2008
## 3172   3172  41    management  married  tertiary      no    1132      no   no   unknown  15   may 2008
## 3173   3173  56      services  married secondary      no    1121     yes   no   unknown  15   may 2008
## 3174   3174  44   blue-collar  married   primary      no    3407     yes   no   unknown  15   may 2008
## 3175   3175  45   blue-collar  married secondary      no     827     yes   no   unknown  15   may 2008
## 3176   3176  43       retired  married   primary      no     471      no  yes   unknown  15   may 2008
## 3177   3177  50    technician  married  tertiary      no    2938     yes   no   unknown  15   may 2008
## 3178   3178  26   blue-collar  married   primary      no    -219     yes  yes   unknown  15   may 2008
## 3179   3179  34      services   single secondary      no     719     yes   no   unknown  15   may 2008
## 3180   3180  39        admin.  married   primary      no    -439     yes   no   unknown  15   may 2008
## 3181   3181  32    management   single  tertiary      no       0     yes   no   unknown  15   may 2008
## 3182   3182  46      services  married secondary      no      74     yes   no   unknown  15   may 2008
## 3183   3183  58    management  married  tertiary      no      44     yes   no   unknown  15   may 2008
## 3184   3184  54  entrepreneur  married secondary      no      52     yes   no   unknown  15   may 2008
## 3185   3185  40      services  married secondary      no     581     yes   no   unknown  15   may 2008
## 3186   3186  42    management  married   primary      no     860     yes   no   unknown  15   may 2008
## 3187   3187  42    unemployed  married   primary      no     259     yes   no   unknown  15   may 2008
## 3188   3188  50   blue-collar  married secondary      no      95     yes   no   unknown  15   may 2008
## 3189   3189  50    management  married  tertiary      no    -516     yes   no   unknown  15   may 2008
## 3190   3190  42     housemaid   single   primary      no    5774     yes   no   unknown  15   may 2008
## 3191   3191  41   blue-collar  married secondary      no    1384     yes   no   unknown  15   may 2008
## 3192   3192  50   blue-collar  married   primary      no    5131     yes   no   unknown  15   may 2008
## 3193   3193  42        admin.  married secondary      no    2918     yes   no   unknown  15   may 2008
## 3194   3194  46        admin.  married secondary      no     556     yes  yes   unknown  15   may 2008
## 3195   3195  48        admin.  married secondary      no    2235     yes  yes   unknown  15   may 2008
## 3196   3196  50    management  married  tertiary     yes    -143     yes   no   unknown  15   may 2008
## 3197   3197  52    technician divorced   primary      no    1500      no   no   unknown  15   may 2008
## 3198   3198  43        admin.   single secondary      no   56831      no   no   unknown  15   may 2008
## 3199   3199  57    management  married  tertiary      no    2440     yes   no   unknown  15   may 2008
## 3200   3200  49        admin.   single secondary      no    2040     yes   no   unknown  15   may 2008
## 3201   3201  30    management  married secondary      no     678     yes   no   unknown  15   may 2008
## 3202   3202  52    technician  married secondary      no    5006     yes   no   unknown  15   may 2008
## 3203   3203  41     housemaid  married   primary      no    3291     yes   no   unknown  15   may 2008
## 3204   3204  47      services  married secondary      no     543     yes   no   unknown  15   may 2008
## 3205   3205  46        admin.  married secondary      no    4048     yes   no   unknown  15   may 2008
## 3206   3206  27      services  married secondary      no       0     yes   no   unknown  15   may 2008
## 3207   3207  46      services  married secondary      no    3269     yes   no   unknown  15   may 2008
## 3208   3208  53  entrepreneur  married  tertiary      no     420     yes   no   unknown  15   may 2008
## 3209   3209  51       retired  married secondary      no       0      no   no   unknown  15   may 2008
## 3210   3210  47    technician  married secondary      no     201     yes   no   unknown  15   may 2008
## 3211   3211  60       retired  married secondary      no    2537     yes  yes   unknown  15   may 2008
## 3212   3212  47    management divorced  tertiary      no     107      no   no   unknown  15   may 2008
## 3213   3213  48      services  married secondary      no    6127     yes   no   unknown  15   may 2008
## 3214   3214  45   blue-collar  married secondary      no    4509     yes   no   unknown  15   may 2008
## 3215   3215  52   blue-collar divorced   primary      no    -191     yes   no   unknown  15   may 2008
## 3216   3216  53       retired  married  tertiary      no     183     yes   no   unknown  15   may 2008
## 3217   3217  54    technician  married  tertiary      no    2883     yes  yes   unknown  15   may 2008
## 3218   3218  46        admin. divorced secondary      no    2515     yes  yes   unknown  15   may 2008
## 3219   3219  48        admin. divorced secondary      no    1108     yes   no   unknown  15   may 2008
## 3220   3220  43       retired  married secondary      no      56     yes  yes   unknown  15   may 2008
## 3221   3221  42    unemployed  married  tertiary      no    1270     yes   no   unknown  15   may 2008
## 3222   3222  56       retired  married secondary      no    1894     yes   no   unknown  15   may 2008
## 3223   3223  48      services divorced secondary      no       0     yes  yes   unknown  15   may 2008
## 3224   3224  45   blue-collar  married   primary      no    2217     yes   no   unknown  15   may 2008
## 3225   3225  51        admin.  married   primary      no    1330     yes   no   unknown  15   may 2008
## 3226   3226  43 self-employed   single   unknown      no    3173      no   no   unknown  15   may 2008
## 3227   3227  42    technician   single  tertiary      no    2157     yes  yes   unknown  15   may 2008
## 3228   3228  44    management  married  tertiary      no    1033     yes   no   unknown  15   may 2008
## 3229   3229  40      services  married secondary      no    4157     yes   no   unknown  15   may 2008
## 3230   3230  57    management  married secondary      no    3381     yes   no   unknown  15   may 2008
## 3231   3231  42    technician   single secondary      no    1882     yes   no   unknown  15   may 2008
## 3232   3232  58      services  married secondary      no       0     yes   no   unknown  15   may 2008
## 3233   3233  40      services divorced secondary      no    1927     yes   no   unknown  15   may 2008
## 3234   3234  49      services divorced secondary      no    3649     yes  yes   unknown  15   may 2008
## 3235   3235  46    management   single secondary      no     244     yes   no   unknown  15   may 2008
## 3236   3236  54    technician divorced secondary      no    1705     yes   no   unknown  15   may 2008
## 3237   3237  60  entrepreneur  married  tertiary      no    1164     yes   no   unknown  15   may 2008
## 3238   3238  42   blue-collar  married secondary      no    9359     yes   no   unknown  15   may 2008
## 3239   3239  43   blue-collar  married   primary      no    1620     yes   no   unknown  15   may 2008
## 3240   3240  41 self-employed  married secondary      no     149     yes   no   unknown  15   may 2008
## 3241   3241  60       retired divorced secondary      no    2479     yes  yes   unknown  15   may 2008
## 3242   3242  51  entrepreneur  married  tertiary      no    6659     yes  yes   unknown  15   may 2008
## 3243   3243  48   blue-collar  married secondary      no    1913     yes   no   unknown  15   may 2008
## 3244   3244  41   blue-collar divorced   primary      no    1563     yes   no   unknown  15   may 2008
## 3245   3245  50   blue-collar   single secondary      no     708     yes   no   unknown  15   may 2008
## 3246   3246  41   blue-collar  married   primary      no    1172     yes   no   unknown  15   may 2008
## 3247   3247  60       retired  married secondary      no    2086     yes   no   unknown  15   may 2008
## 3248   3248  54   blue-collar  married secondary      no     524     yes   no   unknown  15   may 2008
## 3249   3249  49  entrepreneur  married  tertiary      no     221     yes   no   unknown  15   may 2008
## 3250   3250  47    management  married   primary      no      52     yes  yes   unknown  15   may 2008
## 3251   3251  36   blue-collar   single secondary      no    -175     yes   no   unknown  15   may 2008
## 3252   3252  45   blue-collar  married secondary      no    -149     yes   no   unknown  15   may 2008
## 3253   3253  49        admin.  married secondary      no    1530     yes   no   unknown  15   may 2008
## 3254   3254  47   blue-collar  married   primary      no    -100     yes   no   unknown  15   may 2008
## 3255   3255  46        admin.  married secondary      no    1934      no  yes   unknown  15   may 2008
## 3256   3256  29    management  married  tertiary      no     137     yes  yes   unknown  15   may 2008
## 3257   3257  44  entrepreneur  married   primary      no     276     yes  yes   unknown  15   may 2008
## 3258   3258  52   blue-collar divorced   primary      no    1758     yes   no   unknown  15   may 2008
## 3259   3259  33   blue-collar   single secondary      no      49     yes   no   unknown  15   may 2008
## 3260   3260  43   blue-collar  married secondary      no     960     yes   no   unknown  15   may 2008
## 3261   3261  45   blue-collar  married   primary      no     959     yes   no   unknown  15   may 2008
## 3262   3262  42   blue-collar   single secondary      no    1306     yes   no   unknown  15   may 2008
## 3263   3263  50    technician  married secondary      no     892     yes  yes   unknown  15   may 2008
## 3264   3264  58    technician  married secondary      no    5618     yes   no   unknown  15   may 2008
## 3265   3265  50   blue-collar  married   unknown      no     605     yes   no   unknown  15   may 2008
## 3266   3266  56   blue-collar divorced   primary      no    5041     yes   no   unknown  15   may 2008
## 3267   3267  46   blue-collar  married secondary      no    1004     yes   no   unknown  15   may 2008
## 3268   3268  44   blue-collar   single   primary      no     116     yes   no   unknown  15   may 2008
## 3269   3269  52        admin.  married secondary      no     225     yes   no   unknown  15   may 2008
## 3270   3270  55      services  married secondary      no     697     yes   no   unknown  15   may 2008
## 3271   3271  44   blue-collar  married   primary      no    2467     yes   no   unknown  15   may 2008
## 3272   3272  46      services  married secondary      no     523      no   no   unknown  15   may 2008
## 3273   3273  47        admin. divorced secondary      no     106     yes   no   unknown  15   may 2008
## 3274   3274  40   blue-collar divorced secondary      no     793     yes   no   unknown  15   may 2008
## 3275   3275  48   blue-collar  married   primary      no    1757     yes   no   unknown  15   may 2008
## 3276   3276  34     housemaid  married   primary      no      87     yes   no   unknown  15   may 2008
## 3277   3277  46   blue-collar divorced secondary      no    1480     yes   no   unknown  15   may 2008
## 3278   3278  43    unemployed  married   primary      no     960     yes  yes   unknown  15   may 2008
## 3279   3279  40   blue-collar  married   primary      no    2651     yes   no   unknown  15   may 2008
## 3280   3280  39  entrepreneur  married secondary      no       0     yes   no   unknown  15   may 2008
## 3281   3281  57       retired  married   primary      no    3123     yes   no   unknown  15   may 2008
## 3282   3282  54   blue-collar  married   primary      no     950     yes   no   unknown  15   may 2008
## 3283   3283  46    management  married secondary      no    3714     yes   no   unknown  15   may 2008
## 3284   3284  41      services  married secondary      no     957     yes   no   unknown  15   may 2008
## 3285   3285  47      services  married secondary      no    3216     yes   no   unknown  15   may 2008
## 3286   3286  40   blue-collar  married secondary      no    8150     yes   no   unknown  15   may 2008
## 3287   3287  50   blue-collar  married   primary      no    2212     yes   no   unknown  15   may 2008
## 3288   3288  40   blue-collar  married   primary      no     409     yes   no   unknown  15   may 2008
## 3289   3289  47   blue-collar  married   primary     yes   -1385     yes  yes   unknown  15   may 2008
## 3290   3290  57       retired divorced  tertiary      no    2516     yes   no   unknown  15   may 2008
## 3291   3291  47        admin.  married secondary      no    2354     yes   no   unknown  15   may 2008
## 3292   3292  44   blue-collar  married secondary      no     560     yes   no   unknown  15   may 2008
## 3293   3293  47   blue-collar  married secondary      no    5306     yes   no   unknown  15   may 2008
## 3294   3294  53  entrepreneur  married secondary      no     111     yes   no   unknown  15   may 2008
## 3295   3295  59   blue-collar  married   primary      no     320     yes   no   unknown  15   may 2008
## 3296   3296  40  entrepreneur  married secondary      no       0     yes  yes   unknown  15   may 2008
## 3297   3297  60  entrepreneur divorced secondary      no      80     yes   no   unknown  15   may 2008
## 3298   3298  45  entrepreneur  married   primary      no    1953     yes   no   unknown  15   may 2008
## 3299   3299  57   blue-collar  married secondary      no    2192      no   no   unknown  15   may 2008
## 3300   3300  45   blue-collar  married   primary      no    1992     yes   no   unknown  15   may 2008
## 3301   3301  44   blue-collar  married   unknown      no     146     yes   no   unknown  15   may 2008
## 3302   3302  21      services  married secondary      no       0     yes  yes   unknown  15   may 2008
## 3303   3303  42    management   single  tertiary      no    2124     yes   no   unknown  15   may 2008
## 3304   3304  30   blue-collar  married secondary      no       2     yes   no   unknown  15   may 2008
## 3305   3305  57  entrepreneur  married secondary      no    1037     yes  yes   unknown  15   may 2008
## 3306   3306  53        admin. divorced secondary      no    -394     yes   no   unknown  15   may 2008
## 3307   3307  51    management   single  tertiary      no    6510      no   no   unknown  15   may 2008
## 3308   3308  53    technician  married  tertiary      no    4323     yes   no   unknown  15   may 2008
## 3309   3309  54    technician  married  tertiary      no    4582     yes   no   unknown  15   may 2008
## 3310   3310  44    management  married  tertiary      no    2400     yes   no   unknown  15   may 2008
## 3311   3311  56       retired  married secondary      no    1678     yes   no   unknown  15   may 2008
## 3312   3312  46    technician divorced  tertiary      no     405     yes   no   unknown  15   may 2008
## 3313   3313  45    technician  married secondary      no    3583     yes   no   unknown  15   may 2008
## 3314   3314  42   blue-collar  married   primary      no     666     yes   no   unknown  15   may 2008
## 3315   3315  49        admin.   single secondary      no     716     yes   no   unknown  15   may 2008
## 3316   3316  56       retired  married secondary      no     344     yes   no   unknown  15   may 2008
## 3317   3317  44   blue-collar   single secondary      no     641      no   no   unknown  15   may 2008
## 3318   3318  54  entrepreneur  married secondary      no     653     yes   no   unknown  15   may 2008
## 3319   3319  51 self-employed divorced secondary      no     154     yes   no   unknown  15   may 2008
## 3320   3320  49   blue-collar   single   primary      no    3018     yes   no   unknown  15   may 2008
## 3321   3321  45        admin. divorced secondary      no     660     yes   no   unknown  15   may 2008
## 3322   3322  58       retired  married  tertiary      no    2577     yes  yes   unknown  15   may 2008
## 3323   3323  53   blue-collar  married   unknown      no    2785     yes   no   unknown  15   may 2008
## 3324   3324  42    technician  married secondary      no    1865     yes   no   unknown  15   may 2008
## 3325   3325  49       unknown  married   primary      no     341     yes  yes   unknown  15   may 2008
## 3326   3326  53        admin.   single secondary      no    1178     yes   no   unknown  15   may 2008
## 3327   3327  50      services   single secondary      no     516     yes   no   unknown  15   may 2008
## 3328   3328  53  entrepreneur  married  tertiary      no   22370     yes   no   unknown  15   may 2008
## 3329   3329  26   blue-collar  married secondary      no     800     yes   no   unknown  15   may 2008
## 3330   3330  46    management  married  tertiary      no    1217     yes   no   unknown  15   may 2008
## 3331   3331  45      services  married secondary      no    9077     yes   no   unknown  15   may 2008
## 3332   3332  50  entrepreneur  married   primary      no     461     yes   no   unknown  15   may 2008
## 3333   3333  42   blue-collar  married secondary      no     597     yes   no   unknown  15   may 2008
## 3334   3334  42    management  married  tertiary      no       9     yes   no   unknown  15   may 2008
## 3335   3335  54      services  married   unknown      no    7864     yes   no   unknown  15   may 2008
## 3336   3336  60       retired  married  tertiary      no    1224     yes   no   unknown  15   may 2008
## 3337   3337  49   blue-collar   single   primary      no    2623     yes   no   unknown  15   may 2008
## 3338   3338  40  entrepreneur  married   primary      no    3676     yes  yes   unknown  15   may 2008
## 3339   3339  45   blue-collar  married secondary      no     953     yes   no   unknown  15   may 2008
## 3340   3340  40   blue-collar  married   primary      no    1061     yes   no   unknown  15   may 2008
## 3341   3341  60        admin. divorced secondary      no    3020     yes   no   unknown  15   may 2008
## 3342   3342  42   blue-collar  married   primary      no    3405     yes   no   unknown  15   may 2008
## 3343   3343  60       retired  married secondary      no       0     yes   no   unknown  15   may 2008
## 3344   3344  60       retired  married secondary      no    -208     yes   no   unknown  15   may 2008
## 3345   3345  41   blue-collar  married   primary      no     849     yes   no   unknown  15   may 2008
## 3346   3346  60   blue-collar  married   primary      no    3820      no   no   unknown  15   may 2008
## 3347   3347  23    technician   single secondary      no      76     yes   no   unknown  15   may 2008
## 3348   3348  46   blue-collar  married   primary      no     346     yes   no   unknown  15   may 2008
## 3349   3349  44      services  married secondary      no     -22     yes   no   unknown  15   may 2008
## 3350   3350  29   blue-collar   single secondary      no     874     yes   no   unknown  15   may 2008
## 3351   3351  34   blue-collar  married secondary      no     298     yes   no   unknown  15   may 2008
## 3352   3352  59      services  married secondary      no    7475      no   no   unknown  15   may 2008
## 3353   3353  50    management  married  tertiary      no     101     yes   no   unknown  15   may 2008
## 3354   3354  60        admin.  married   unknown      no    2667     yes   no   unknown  15   may 2008
## 3355   3355  49   blue-collar  married secondary      no    2219     yes   no   unknown  15   may 2008
## 3356   3356  55   blue-collar  married   primary      no     158     yes   no   unknown  15   may 2008
## 3357   3357  54   blue-collar  married   primary      no    2933     yes   no   unknown  15   may 2008
## 3358   3358  42   blue-collar  married   primary      no    -181     yes   no   unknown  15   may 2008
## 3359   3359  60   blue-collar  married   primary      no    5788     yes   no   unknown  15   may 2008
## 3360   3360  47      services  married secondary      no    2796     yes   no   unknown  15   may 2008
## 3361   3361  41    management  married secondary      no    6526      no   no   unknown  15   may 2008
## 3362   3362  47        admin.   single  tertiary      no    1192     yes   no   unknown  15   may 2008
## 3363   3363  41    technician  married secondary      no     665     yes   no   unknown  15   may 2008
## 3364   3364  57       retired  married secondary      no     703     yes   no   unknown  15   may 2008
## 3365   3365  53    management  married  tertiary      no    4928     yes   no   unknown  15   may 2008
## 3366   3366  44   blue-collar  married secondary      no    1786     yes   no   unknown  15   may 2008
## 3367   3367  35  entrepreneur   single  tertiary      no     -68     yes  yes   unknown  15   may 2008
## 3368   3368  41     housemaid  married  tertiary      no      38     yes   no   unknown  15   may 2008
## 3369   3369  28       student   single secondary      no       0     yes   no   unknown  15   may 2008
## 3370   3370  55        admin.  married secondary      no    1105     yes  yes   unknown  15   may 2008
## 3371   3371  55        admin.  married secondary      no    9039     yes   no   unknown  15   may 2008
## 3372   3372  40      services  married   primary      no      -9     yes   no   unknown  15   may 2008
## 3373   3373  35    management  married  tertiary      no       6     yes  yes   unknown  15   may 2008
## 3374   3374  58    management divorced  tertiary      no     577      no   no   unknown  15   may 2008
## 3375   3375  25    management   single  tertiary      no       6     yes  yes   unknown  15   may 2008
## 3376   3376  43    technician  married secondary      no      78     yes   no   unknown  15   may 2008
## 3377   3377  29      services   single secondary      no      20     yes   no   unknown  15   may 2008
## 3378   3378  46   blue-collar   single   primary      no      87      no   no   unknown  15   may 2008
## 3379   3379  41        admin.  married   primary      no    -306     yes   no   unknown  15   may 2008
## 3380   3380  60       retired  married   unknown      no      79     yes   no   unknown  15   may 2008
## 3381   3381  47   blue-collar  married   primary      no       0     yes   no   unknown  15   may 2008
## 3382   3382  60       retired  married   primary      no     751     yes   no   unknown  15   may 2008
## 3383   3383  33   blue-collar  married   primary      no       0     yes   no   unknown  15   may 2008
## 3384   3384  34        admin.   single secondary      no    1704     yes   no   unknown  15   may 2008
## 3385   3385  57        admin.  married   unknown      no       0     yes   no   unknown  15   may 2008
## 3386   3386  42      services  married   unknown      no       8     yes   no   unknown  15   may 2008
## 3387   3387  47   blue-collar  married secondary      no      39     yes   no   unknown  15   may 2008
## 3388   3388  33    technician divorced   primary      no      20     yes   no   unknown  15   may 2008
## 3389   3389  43    technician   single secondary      no     293     yes   no   unknown  15   may 2008
## 3390   3390  40    management   single  tertiary      no     157     yes   no   unknown  15   may 2008
## 3391   3391  35   blue-collar   single secondary      no     487     yes   no   unknown  15   may 2008
## 3392   3392  26    technician   single  tertiary      no     192     yes   no   unknown  15   may 2008
## 3393   3393  53   blue-collar  married secondary      no     136     yes   no   unknown  15   may 2008
## 3394   3394  55   blue-collar  married secondary      no    1328     yes   no   unknown  15   may 2008
## 3395   3395  46    management  married  tertiary      no    1038     yes  yes   unknown  15   may 2008
## 3396   3396  24      services  married secondary      no      51     yes  yes   unknown  15   may 2008
## 3397   3397  47   blue-collar  married secondary      no    3008     yes  yes   unknown  15   may 2008
## 3398   3398  41   blue-collar  married secondary     yes    -204     yes   no   unknown  15   may 2008
## 3399   3399  55      services divorced   primary      no    2923     yes   no   unknown  15   may 2008
## 3400   3400  32   blue-collar  married secondary      no     231     yes   no   unknown  15   may 2008
## 3401   3401  30    technician  married  tertiary      no    -256     yes   no   unknown  15   may 2008
## 3402   3402  54      services divorced   primary      no     234     yes   no   unknown  15   may 2008
## 3403   3403  41    technician  married secondary      no     288     yes   no   unknown  15   may 2008
## 3404   3404  42    management   single  tertiary      no    1146     yes   no   unknown  15   may 2008
## 3405   3405  43   blue-collar  married secondary      no    3060     yes   no   unknown  15   may 2008
## 3406   3406  54        admin.  married   unknown      no     907     yes   no   unknown  15   may 2008
## 3407   3407  56    management  married  tertiary      no     334     yes   no   unknown  15   may 2008
## 3408   3408  54 self-employed divorced secondary      no    1374     yes   no   unknown  15   may 2008
## 3409   3409  30   blue-collar  married   primary      no     124     yes   no   unknown  15   may 2008
## 3410   3410  53       retired  married  tertiary      no      74     yes   no   unknown  15   may 2008
## 3411   3411  45    management  married  tertiary      no    1363     yes   no   unknown  15   may 2008
## 3412   3412  41   blue-collar  married secondary      no     680     yes   no   unknown  15   may 2008
## 3413   3413  28   blue-collar  married secondary      no      86     yes  yes   unknown  15   may 2008
## 3414   3414  58        admin. divorced secondary      no    1713      no   no   unknown  15   may 2008
## 3415   3415  57      services  married   primary      no    3990     yes   no   unknown  15   may 2008
## 3416   3416  54        admin.  married   unknown      no    3965     yes   no   unknown  15   may 2008
## 3417   3417  39    unemployed divorced secondary      no     193     yes   no   unknown  15   may 2008
## 3418   3418  41    management  married  tertiary      no    6060     yes   no   unknown  15   may 2008
## 3419   3419  60      services  married   unknown      no     132     yes   no   unknown  15   may 2008
## 3420   3420  42    management  married  tertiary      no    1323     yes  yes   unknown  15   may 2008
## 3421   3421  47   blue-collar  married secondary      no    3237     yes   no   unknown  15   may 2008
## 3422   3422  41  entrepreneur divorced  tertiary      no     252      no   no   unknown  15   may 2008
## 3423   3423  46   blue-collar  married secondary      no      84     yes   no   unknown  15   may 2008
## 3424   3424  45    management   single  tertiary      no       0     yes   no   unknown  15   may 2008
## 3425   3425  48      services   single   primary      no     848     yes   no   unknown  15   may 2008
## 3426   3426  57      services  married secondary      no      84     yes   no   unknown  15   may 2008
## 3427   3427  54   blue-collar divorced   primary      no     190     yes   no   unknown  15   may 2008
## 3428   3428  30    technician  married secondary      no    1534     yes  yes   unknown  15   may 2008
## 3429   3429  41    management   single  tertiary      no    1278     yes   no   unknown  15   may 2008
## 3430   3430  46   blue-collar  married   primary      no     252     yes   no   unknown  15   may 2008
## 3431   3431  35   blue-collar   single   primary      no    1215     yes   no   unknown  15   may 2008
## 3432   3432  28   blue-collar   single   primary      no    -457     yes   no   unknown  15   may 2008
## 3433   3433  58    management divorced  tertiary      no     347      no   no   unknown  15   may 2008
## 3434   3434  35    technician divorced  tertiary      no       0     yes   no   unknown  15   may 2008
## 3435   3435  25    technician   single  tertiary      no     468     yes   no   unknown  15   may 2008
## 3436   3436  56    technician  married secondary      no      28     yes   no   unknown  15   may 2008
## 3437   3437  41      services   single secondary      no     323     yes   no   unknown  15   may 2008
## 3438   3438  44    management  married secondary      no      38     yes   no   unknown  15   may 2008
## 3439   3439  36    unemployed  married secondary     yes    -318     yes   no   unknown  15   may 2008
## 3440   3440  41      services  married secondary      no     714     yes  yes   unknown  15   may 2008
## 3441   3441  58 self-employed  married secondary      no       0     yes   no   unknown  15   may 2008
## 3442   3442  46   blue-collar  married secondary      no     536     yes   no   unknown  15   may 2008
## 3443   3443  42      services  married secondary      no    1048     yes   no   unknown  15   may 2008
## 3444   3444  58    technician  married   unknown      no      49     yes   no   unknown  15   may 2008
## 3445   3445  53        admin.  married secondary      no    -197     yes  yes   unknown  15   may 2008
## 3446   3446  51   blue-collar  married secondary      no    1779     yes   no   unknown  15   may 2008
## 3447   3447  38     housemaid  married secondary      no    1372     yes  yes   unknown  15   may 2008
## 3448   3448  54   blue-collar  married   primary      no      24     yes   no   unknown  15   may 2008
## 3449   3449  46 self-employed   single  tertiary      no    1934     yes   no   unknown  15   may 2008
## 3450   3450  39    management divorced  tertiary      no    9541      no   no   unknown  15   may 2008
## 3451   3451  22       student   single secondary      no     364     yes   no   unknown  15   may 2008
## 3452   3452  47        admin. divorced   primary      no     357     yes  yes   unknown  15   may 2008
## 3453   3453  34      services divorced secondary      no     202     yes   no   unknown  15   may 2008
## 3454   3454  42        admin.  married secondary      no     281     yes   no   unknown  15   may 2008
## 3455   3455  44    technician  married  tertiary      no    4580     yes   no   unknown  15   may 2008
## 3456   3456  45      services  married secondary      no    4060     yes   no   unknown  15   may 2008
## 3457   3457  38        admin.  married secondary      no       0     yes   no   unknown  15   may 2008
## 3458   3458  46   blue-collar  married   primary      no    1114     yes   no   unknown  15   may 2008
## 3459   3459  34    technician  married secondary      no       4     yes   no   unknown  15   may 2008
## 3460   3460  41    technician divorced secondary      no     536     yes   no   unknown  15   may 2008
## 3461   3461  27   blue-collar   single   primary      no     431     yes   no   unknown  15   may 2008
## 3462   3462  56    unemployed  married secondary      no    2552     yes   no   unknown  15   may 2008
## 3463   3463  43    management  married  tertiary      no    8016     yes   no   unknown  15   may 2008
## 3464   3464  34    management  married   unknown     yes    -353     yes   no   unknown  15   may 2008
## 3465   3465  25       student   single secondary      no    1139     yes   no   unknown  15   may 2008
## 3466   3466  35    unemployed  married   primary      no     494     yes   no   unknown  15   may 2008
## 3467   3467  46  entrepreneur  married   unknown      no     676     yes  yes   unknown  15   may 2008
## 3468   3468  32        admin.   single secondary      no     287      no   no   unknown  15   may 2008
## 3469   3469  55    technician  married secondary      no     741     yes   no   unknown  15   may 2008
## 3470   3470  40       retired  married secondary      no    1842      no   no   unknown  15   may 2008
## 3471   3471  43    management  married  tertiary      no    4004     yes   no   unknown  15   may 2008
## 3472   3472  41  entrepreneur  married  tertiary      no     102      no   no   unknown  15   may 2008
## 3473   3473  33   blue-collar   single   primary      no     279     yes   no   unknown  15   may 2008
## 3474   3474  32    management   single secondary      no       6     yes   no   unknown  15   may 2008
## 3475   3475  39    technician  married   primary      no     644     yes   no   unknown  15   may 2008
## 3476   3476  42    management divorced  tertiary      no     497      no   no   unknown  15   may 2008
## 3477   3477  33    technician   single secondary      no     402     yes  yes   unknown  15   may 2008
## 3478   3478  32      services  married secondary      no     401     yes   no   unknown  15   may 2008
## 3479   3479  46        admin.  married   primary      no      31     yes   no   unknown  15   may 2008
## 3480   3480  42   blue-collar  married secondary      no    -628     yes  yes   unknown  15   may 2008
## 3481   3481  39        admin.  married secondary      no     598     yes   no   unknown  15   may 2008
## 3482   3482  43   blue-collar divorced   primary      no      92     yes   no   unknown  15   may 2008
## 3483   3483  33    management   single  tertiary      no    -625     yes   no   unknown  15   may 2008
## 3484   3484  59    management  married  tertiary      no    2319     yes   no   unknown  15   may 2008
## 3485   3485  48  entrepreneur  married  tertiary      no     981     yes   no   unknown  15   may 2008
## 3486   3486  31   blue-collar  married   primary      no     605     yes   no   unknown  15   may 2008
## 3487   3487  47    management divorced  tertiary      no   10399     yes   no   unknown  15   may 2008
## 3488   3488  54    technician divorced secondary      no     784     yes  yes   unknown  15   may 2008
## 3489   3489  48   blue-collar  married   primary      no     680     yes   no   unknown  15   may 2008
## 3490   3490  33    management divorced  tertiary      no     893     yes   no   unknown  15   may 2008
## 3491   3491  27      services  married secondary      no      94     yes   no   unknown  15   may 2008
## 3492   3492  47        admin.  married secondary      no     257     yes   no   unknown  15   may 2008
## 3493   3493  56   blue-collar   single   primary      no     739     yes   no   unknown  15   may 2008
## 3494   3494  26    technician   single secondary      no       2     yes  yes   unknown  15   may 2008
## 3495   3495  55    management  married   unknown     yes    -171     yes   no   unknown  15   may 2008
## 3496   3496  33   blue-collar  married secondary      no     217     yes   no   unknown  15   may 2008
## 3497   3497  52   blue-collar  married   unknown      no     826     yes   no   unknown  15   may 2008
## 3498   3498  60      services   single   primary      no     313     yes   no   unknown  15   may 2008
## 3499   3499  50    management  married  tertiary      no     106     yes   no   unknown  15   may 2008
## 3500   3500  43   blue-collar  married secondary      no    4520     yes   no   unknown  15   may 2008
## 3501   3501  29    management  married  tertiary      no   10576      no   no   unknown  15   may 2008
## 3502   3502  54    management  married   primary      no     366     yes   no   unknown  15   may 2008
## 3503   3503  30        admin. divorced secondary      no     370     yes   no   unknown  15   may 2008
## 3504   3504  50    management  married  tertiary      no    4904     yes   no   unknown  15   may 2008
## 3505   3505  48    technician  married secondary      no       0     yes  yes   unknown  15   may 2008
## 3506   3506  55      services divorced secondary      no      72     yes  yes   unknown  15   may 2008
## 3507   3507  56     housemaid divorced secondary      no       0      no   no   unknown  15   may 2008
## 3508   3508  48    management  married   unknown      no    1103     yes   no   unknown  15   may 2008
## 3509   3509  36   blue-collar   single secondary      no    1392     yes   no   unknown  15   may 2008
## 3510   3510  41       retired divorced   primary      no    -233     yes   no   unknown  15   may 2008
## 3511   3511  30    management   single  tertiary      no      78     yes   no   unknown  15   may 2008
## 3512   3512  59    management   single secondary      no     671     yes  yes   unknown  15   may 2008
## 3513   3513  27   blue-collar   single secondary      no     228     yes  yes   unknown  15   may 2008
## 3514   3514  55       unknown  married   unknown      no     666      no   no   unknown  15   may 2008
## 3515   3515  45      services  married secondary      no     520     yes   no   unknown  15   may 2008
## 3516   3516  58   blue-collar  married   primary      no    3501     yes   no   unknown  15   may 2008
## 3517   3517  44    technician  married secondary      no     185     yes   no   unknown  15   may 2008
## 3518   3518  43   blue-collar  married   primary      no     108     yes  yes   unknown  15   may 2008
## 3519   3519  59       retired  married   primary      no    1423     yes   no   unknown  15   may 2008
## 3520   3520  41   blue-collar  married   primary      no    2453     yes   no   unknown  15   may 2008
## 3521   3521  43     housemaid  married   primary      no      18     yes  yes   unknown  15   may 2008
## 3522   3522  49      services   single secondary      no    3061     yes   no   unknown  15   may 2008
## 3523   3523  44   blue-collar  married   primary      no       0     yes   no   unknown  15   may 2008
## 3524   3524  48   blue-collar  married   primary      no     559     yes   no   unknown  15   may 2008
## 3525   3525  40   blue-collar  married   primary      no     902     yes   no   unknown  15   may 2008
## 3526   3526  43   blue-collar   single secondary      no     421     yes   no   unknown  15   may 2008
## 3527   3527  26   blue-collar  married   primary      no     500     yes   no   unknown  15   may 2008
## 3528   3528  46   blue-collar  married secondary      no     756     yes   no   unknown  15   may 2008
## 3529   3529  58   blue-collar  married secondary      no     288     yes   no   unknown  15   may 2008
## 3530   3530  53   blue-collar  married secondary      no    1140     yes   no   unknown  15   may 2008
## 3531   3531  56      services  married secondary      no    2658     yes   no   unknown  15   may 2008
## 3532   3532  43   blue-collar  married   primary      no     632     yes   no   unknown  15   may 2008
## 3533   3533  36   blue-collar   single   primary      no     263     yes   no   unknown  15   may 2008
## 3534   3534  34   blue-collar  married   unknown      no     -17     yes   no   unknown  15   may 2008
## 3535   3535  51   blue-collar  married secondary      no     701     yes   no   unknown  15   may 2008
## 3536   3536  51   blue-collar  married   primary      no    4497     yes   no   unknown  15   may 2008
## 3537   3537  45   blue-collar  married   primary      no     810     yes   no   unknown  15   may 2008
## 3538   3538  54   blue-collar  married   primary      no    -219     yes   no   unknown  15   may 2008
## 3539   3539  42        admin.  married secondary      no     679     yes   no   unknown  15   may 2008
## 3540   3540  53      services  married secondary      no    2925     yes   no   unknown  15   may 2008
## 3541   3541  35 self-employed   single   primary      no     181     yes   no   unknown  15   may 2008
## 3542   3542  49    management  married  tertiary      no    3840     yes   no   unknown  15   may 2008
## 3543   3543  55    technician  married secondary      no    2014     yes  yes   unknown  15   may 2008
## 3544   3544  31    technician   single secondary      no    1819     yes   no   unknown  15   may 2008
## 3545   3545  52   blue-collar  married secondary      no     665     yes   no   unknown  15   may 2008
## 3546   3546  50     housemaid  married   primary      no     395     yes   no   unknown  15   may 2008
## 3547   3547  32      services  married secondary      no      55     yes   no   unknown  15   may 2008
## 3548   3548  34   blue-collar  married secondary      no     326     yes  yes   unknown  15   may 2008
## 3549   3549  42    technician   single secondary      no    1364     yes   no   unknown  15   may 2008
## 3550   3550  33    management   single secondary     yes    -174     yes   no   unknown  15   may 2008
## 3551   3551  43    management  married  tertiary      no    5670     yes   no   unknown  15   may 2008
## 3552   3552  31   blue-collar divorced secondary      no    1125      no  yes   unknown  15   may 2008
## 3553   3553  25   blue-collar   single secondary      no       0     yes   no   unknown  15   may 2008
## 3554   3554  49    technician  married secondary      no    3657     yes   no   unknown  15   may 2008
## 3555   3555  56        admin.  married secondary      no    2256     yes   no   unknown  15   may 2008
## 3556   3556  43   blue-collar  married   primary      no     778     yes  yes   unknown  15   may 2008
## 3557   3557  41   blue-collar  married secondary      no      59     yes   no   unknown  15   may 2008
## 3558   3558  46   blue-collar  married secondary      no     668     yes   no   unknown  15   may 2008
## 3559   3559  60       retired   single  tertiary      no    7440     yes   no   unknown  15   may 2008
## 3560   3560  48   blue-collar  married   primary      no    1001     yes   no   unknown  15   may 2008
## 3561   3561  57        admin. divorced   primary      no       1      no   no   unknown  15   may 2008
## 3562   3562  42   blue-collar  married   primary      no    1320      no   no   unknown  15   may 2008
## 3563   3563  50   blue-collar  married secondary      no    1604     yes   no   unknown  15   may 2008
## 3564   3564  36    management  married  tertiary      no     900     yes   no   unknown  15   may 2008
## 3565   3565  44    management  married secondary      no    2984     yes   no   unknown  15   may 2008
## 3566   3566  40   blue-collar  married   primary      no    2562     yes   no   unknown  15   may 2008
## 3567   3567  55        admin.  married secondary      no    1102     yes   no   unknown  15   may 2008
## 3568   3568  24   blue-collar   single   primary      no     758     yes   no   unknown  15   may 2008
## 3569   3569  52   blue-collar  married   primary      no    1079     yes   no   unknown  15   may 2008
## 3570   3570  49      services  married secondary      no    2201     yes   no   unknown  15   may 2008
## 3571   3571  30      services  married secondary      no     271     yes   no   unknown  15   may 2008
## 3572   3572  32      services   single secondary      no     772     yes   no   unknown  15   may 2008
## 3573   3573  46    technician divorced secondary      no     435     yes   no   unknown  15   may 2008
## 3574   3574  36   blue-collar  married secondary      no     412     yes   no   unknown  15   may 2008
## 3575   3575  44    technician divorced secondary      no     809     yes   no   unknown  15   may 2008
## 3576   3576  48   blue-collar  married   primary      no     575      no   no   unknown  15   may 2008
## 3577   3577  49    technician  married secondary      no    3033      no   no   unknown  15   may 2008
## 3578   3578  44   blue-collar  married   primary      no     412     yes   no   unknown  15   may 2008
## 3579   3579  23      services   single secondary      no     496     yes   no   unknown  15   may 2008
## 3580   3580  45   blue-collar divorced   primary      no     749     yes   no   unknown  15   may 2008
## 3581   3581  54    management   single  tertiary      no    1439     yes   no   unknown  15   may 2008
## 3582   3582  43    management  married  tertiary      no    2767     yes   no   unknown  15   may 2008
## 3583   3583  44   blue-collar  married   primary      no     140     yes   no   unknown  15   may 2008
## 3584   3584  52   blue-collar  married   primary      no    4015     yes   no   unknown  15   may 2008
## 3585   3585  37   blue-collar  married secondary      no      77     yes   no   unknown  15   may 2008
## 3586   3586  53    management   single  tertiary      no    1074     yes   no   unknown  15   may 2008
## 3587   3587  31   blue-collar  married secondary      no    -720     yes  yes   unknown  15   may 2008
## 3588   3588  56   blue-collar  married   primary      no     690     yes   no   unknown  15   may 2008
## 3589   3589  40    management  married   primary      no    1231     yes  yes   unknown  15   may 2008
## 3590   3590  58    management  married  tertiary      no     714     yes   no   unknown  15   may 2008
## 3591   3591  42   blue-collar  married   primary      no    1742     yes   no   unknown  15   may 2008
## 3592   3592  59       retired divorced secondary      no     337     yes   no   unknown  15   may 2008
## 3593   3593  45    technician  married secondary      no    -237     yes  yes   unknown  15   may 2008
## 3594   3594  53        admin.  married secondary      no    1739     yes   no   unknown  15   may 2008
## 3595   3595  55    technician  married  tertiary      no     874     yes   no   unknown  15   may 2008
## 3596   3596  60        admin.  married secondary      no    1880     yes   no   unknown  15   may 2008
## 3597   3597  48  entrepreneur  married   primary      no    3705     yes   no   unknown  15   may 2008
## 3598   3598  43    technician   single secondary      no    1195     yes   no   unknown  15   may 2008
## 3599   3599  47    technician  married secondary      no    2781     yes   no   unknown  15   may 2008
## 3600   3600  33   blue-collar  married secondary      no     175     yes   no   unknown  15   may 2008
## 3601   3601  37      services  married secondary      no       1      no   no   unknown  15   may 2008
## 3602   3602  60    management divorced   primary      no      38     yes   no   unknown  15   may 2008
## 3603   3603  52   blue-collar  married secondary      no    2206     yes   no   unknown  15   may 2008
## 3604   3604  31        admin.   single secondary      no     358     yes   no   unknown  15   may 2008
## 3605   3605  31    unemployed   single   primary      no       0     yes   no   unknown  15   may 2008
## 3606   3606  53    technician  married secondary      no    4541     yes   no   unknown  15   may 2008
## 3607   3607  45   blue-collar  married secondary      no     120     yes  yes   unknown  15   may 2008
## 3608   3608  56   blue-collar  married secondary      no    -382     yes   no   unknown  15   may 2008
## 3609   3609  36    technician  married secondary      no     146     yes  yes   unknown  15   may 2008
## 3610   3610  40      services  married secondary      no     574     yes   no   unknown  15   may 2008
## 3611   3611  42   blue-collar  married   primary      no    2519     yes   no   unknown  15   may 2008
## 3612   3612  52        admin.  married secondary      no     395     yes   no   unknown  15   may 2008
## 3613   3613  46 self-employed divorced  tertiary      no    8717     yes   no   unknown  15   may 2008
## 3614   3614  59        admin. divorced secondary      no     975     yes   no   unknown  15   may 2008
## 3615   3615  41    technician  married secondary      no     768     yes   no   unknown  15   may 2008
## 3616   3616  61       retired  married secondary      no     280     yes   no   unknown  15   may 2008
## 3617   3617  57    management  married  tertiary      no     388      no  yes   unknown  15   may 2008
## 3618   3618  32        admin.   single secondary      no     289      no   no   unknown  15   may 2008
## 3619   3619  55    management   single  tertiary      no    1092     yes  yes   unknown  15   may 2008
## 3620   3620  54    management  married secondary      no    1394     yes   no   unknown  15   may 2008
## 3621   3621  55      services  married secondary      no     151     yes   no   unknown  15   may 2008
## 3622   3622  31        admin.  married   unknown      no    -295     yes   no   unknown  15   may 2008
## 3623   3623  43   blue-collar  married   primary      no    7727     yes   no   unknown  15   may 2008
## 3624   3624  49       retired  married   unknown      no     247      no   no   unknown  15   may 2008
## 3625   3625  31   blue-collar   single secondary      no      33     yes   no   unknown  15   may 2008
## 3626   3626  34   blue-collar  married secondary      no     452     yes   no   unknown  15   may 2008
## 3627   3627  31    management   single  tertiary      no     635     yes   no   unknown  15   may 2008
## 3628   3628  23      services   single secondary      no      75     yes   no   unknown  15   may 2008
## 3629   3629  35    technician   single  tertiary      no    1455     yes   no   unknown  15   may 2008
## 3630   3630  43   blue-collar  married   primary      no    2605     yes   no   unknown  15   may 2008
## 3631   3631  31    technician   single  tertiary      no      56      no   no   unknown  15   may 2008
## 3632   3632  45    technician  married secondary      no      89     yes   no   unknown  15   may 2008
## 3633   3633  29    technician  married secondary      no      84     yes   no   unknown  15   may 2008
## 3634   3634  27    technician  married secondary      no       7     yes   no   unknown  15   may 2008
## 3635   3635  52   blue-collar  married   primary      no     238     yes   no   unknown  15   may 2008
## 3636   3636  58    management  married  tertiary      no    2360      no   no   unknown  15   may 2008
## 3637   3637  39   blue-collar   single   primary      no     -21      no   no   unknown  15   may 2008
## 3638   3638  52    technician divorced secondary      no     409     yes   no   unknown  15   may 2008
## 3639   3639  60       retired  married   primary      no     894     yes   no   unknown  15   may 2008
## 3640   3640  52      services  married secondary      no     108     yes   no   unknown  15   may 2008
## 3641   3641  45        admin.  married secondary      no     805     yes   no   unknown  15   may 2008
## 3642   3642  58   blue-collar  married   primary      no    2547      no   no   unknown  15   may 2008
## 3643   3643  56  entrepreneur  married  tertiary      no    -124     yes   no   unknown  15   may 2008
## 3644   3644  51   blue-collar  married secondary      no    1414     yes   no   unknown  15   may 2008
## 3645   3645  50   blue-collar  married secondary      no    6258     yes   no   unknown  15   may 2008
## 3646   3646  39 self-employed  married  tertiary      no    -176     yes   no   unknown  15   may 2008
## 3647   3647  58    management divorced  tertiary      no    1533      no   no   unknown  15   may 2008
## 3648   3648  51 self-employed   single secondary      no    1640     yes   no   unknown  15   may 2008
## 3649   3649  45   blue-collar  married   primary      no      91     yes   no   unknown  15   may 2008
## 3650   3650  41    management   single  tertiary      no     480     yes   no   unknown  15   may 2008
## 3651   3651  28   blue-collar   single   primary      no     643     yes   no   unknown  15   may 2008
## 3652   3652  51   blue-collar  married   unknown      no    2547     yes   no   unknown  15   may 2008
## 3653   3653  45   blue-collar  married   unknown      no     110     yes   no   unknown  15   may 2008
## 3654   3654  46        admin.  married secondary      no      35      no   no   unknown  16   may 2008
## 3655   3655  43    management   single secondary      no    -228     yes  yes   unknown  16   may 2008
## 3656   3656  53       retired  married secondary      no    1139     yes   no   unknown  16   may 2008
## 3657   3657  50        admin. divorced secondary      no    1332     yes   no   unknown  16   may 2008
## 3658   3658  55    technician  married secondary      no       0     yes   no   unknown  16   may 2008
## 3659   3659  52   blue-collar  married   primary      no     779     yes   no   unknown  16   may 2008
## 3660   3660  53        admin.  married   primary      no     228     yes   no   unknown  16   may 2008
## 3661   3661  51   blue-collar  married secondary      no      22     yes   no   unknown  16   may 2008
## 3662   3662  31        admin.   single secondary      no       0     yes   no   unknown  16   may 2008
## 3663   3663  41    technician   single secondary      no    2919     yes   no   unknown  16   may 2008
## 3664   3664  39   blue-collar  married   primary      no     186     yes   no   unknown  16   may 2008
## 3665   3665  60    management divorced secondary      no     773     yes  yes   unknown  16   may 2008
## 3666   3666  39    technician  married   unknown      no     880     yes   no   unknown  16   may 2008
## 3667   3667  41    management  married secondary      no     218     yes   no   unknown  16   may 2008
## 3668   3668  36   blue-collar  married secondary      no     512     yes   no   unknown  16   may 2008
## 3669   3669  40   blue-collar   single secondary      no    1101     yes   no   unknown  16   may 2008
## 3670   3670  29   blue-collar  married secondary      no    1956     yes   no   unknown  16   may 2008
## 3671   3671  32        admin.  married secondary      no       0      no   no   unknown  16   may 2008
## 3672   3672  45   blue-collar divorced   primary      no     104     yes   no   unknown  16   may 2008
## 3673   3673  32    technician divorced secondary      no      75      no   no   unknown  16   may 2008
## 3674   3674  31     housemaid   single secondary      no    1301     yes   no   unknown  16   may 2008
## 3675   3675  58       retired divorced   primary      no       6      no   no   unknown  16   may 2008
## 3676   3676  40    technician  married secondary      no      75     yes   no   unknown  16   may 2008
## 3677   3677  40      services  married   primary      no      44     yes   no   unknown  16   may 2008
## 3678   3678  36      services   single   unknown      no     281     yes   no   unknown  16   may 2008
## 3679   3679  40        admin.  married secondary      no       2     yes   no   unknown  16   may 2008
## 3680   3680  35    management   single  tertiary      no     205     yes   no   unknown  16   may 2008
## 3681   3681  39   blue-collar  married   primary      no    2133     yes  yes   unknown  16   may 2008
## 3682   3682  39    technician  married  tertiary      no      94     yes  yes   unknown  16   may 2008
## 3683   3683  30 self-employed   single  tertiary      no     901     yes  yes   unknown  16   may 2008
## 3684   3684  57    management  married  tertiary      no    3431     yes   no   unknown  16   may 2008
## 3685   3685  60      services  married secondary      no    8837     yes   no   unknown  16   may 2008
## 3686   3686  55    technician  married secondary      no     726     yes   no   unknown  16   may 2008
## 3687   3687  40    technician  married secondary      no      26     yes   no   unknown  16   may 2008
## 3688   3688  27       student   single  tertiary      no      66     yes   no   unknown  16   may 2008
## 3689   3689  40        admin.  married secondary      no    2523     yes   no   unknown  16   may 2008
## 3690   3690  28    management  married  tertiary      no      82     yes  yes   unknown  16   may 2008
## 3691   3691  32    management  married  tertiary      no       0     yes   no   unknown  16   may 2008
## 3692   3692  53    management   single secondary      no    5558     yes   no   unknown  16   may 2008
## 3693   3693  29        admin.   single secondary      no    -507     yes   no   unknown  16   may 2008
## 3694   3694  29    technician   single  tertiary      no      47     yes   no   unknown  16   may 2008
## 3695   3695  45 self-employed  married   unknown      no    -257      no   no   unknown  16   may 2008
## 3696   3696  32    management  married secondary      no    1423     yes   no   unknown  16   may 2008
## 3697   3697  47      services  married secondary      no      51     yes  yes   unknown  16   may 2008
## 3698   3698  40      services  married secondary      no    1688      no   no   unknown  16   may 2008
## 3699   3699  33      services   single secondary      no       0     yes   no   unknown  16   may 2008
## 3700   3700  55     housemaid  married   primary      no    1000     yes   no   unknown  16   may 2008
## 3701   3701  31   blue-collar   single secondary      no       0     yes  yes   unknown  16   may 2008
## 3702   3702  33    management  married  tertiary      no     273     yes   no   unknown  16   may 2008
## 3703   3703  42        admin. divorced secondary      no     153     yes   no   unknown  16   may 2008
## 3704   3704  31        admin. divorced  tertiary      no     146     yes   no   unknown  16   may 2008
## 3705   3705  41   blue-collar  married   unknown      no     732     yes   no   unknown  16   may 2008
## 3706   3706  43        admin.   single secondary      no    2539     yes   no   unknown  16   may 2008
## 3707   3707  36      services  married secondary      no     208     yes   no   unknown  16   may 2008
## 3708   3708  48    management  married  tertiary      no     542     yes   no   unknown  16   may 2008
## 3709   3709  31 self-employed   single  tertiary      no     144     yes   no   unknown  16   may 2008
## 3710   3710  45    technician  married secondary      no     999     yes   no   unknown  16   may 2008
## 3711   3711  43   blue-collar  married secondary      no      19     yes   no   unknown  16   may 2008
## 3712   3712  42        admin. divorced secondary      no      63      no   no   unknown  16   may 2008
## 3713   3713  40      services  married secondary      no     446     yes   no   unknown  16   may 2008
## 3714   3714  29   blue-collar  married secondary      no     832     yes   no   unknown  16   may 2008
## 3715   3715  26   blue-collar  married secondary      no     246     yes   no   unknown  16   may 2008
## 3716   3716  53    unemployed  married secondary      no      76     yes  yes   unknown  16   may 2008
## 3717   3717  31    technician divorced secondary      no     268      no   no   unknown  16   may 2008
## 3718   3718  25        admin.  married secondary      no      16     yes   no   unknown  16   may 2008
## 3719   3719  26        admin.   single secondary      no    -235     yes   no   unknown  16   may 2008
## 3720   3720  36        admin.   single secondary      no       0     yes  yes   unknown  16   may 2008
## 3721   3721  43      services divorced secondary      no     207     yes   no   unknown  16   may 2008
## 3722   3722  45        admin. divorced secondary      no     109     yes   no   unknown  16   may 2008
## 3723   3723  56    management divorced  tertiary      no     975     yes   no   unknown  16   may 2008
## 3724   3724  51    technician  married secondary      no     143     yes   no   unknown  16   may 2008
## 3725   3725  47   blue-collar  married   primary      no    1756     yes   no   unknown  16   may 2008
## 3726   3726  44     housemaid  married   primary     yes    -972     yes  yes   unknown  16   may 2008
## 3727   3727  31      services  married secondary      no       5     yes   no   unknown  16   may 2008
## 3728   3728  46    management  married secondary      no      36     yes   no   unknown  16   may 2008
## 3729   3729  32    management   single  tertiary      no       0      no   no   unknown  16   may 2008
## 3730   3730  31        admin.  married secondary      no     468     yes   no   unknown  16   may 2008
## 3731   3731  45   blue-collar  married   primary      no     804     yes   no   unknown  16   may 2008
## 3732   3732  31    unemployed   single secondary      no     199     yes   no   unknown  16   may 2008
## 3733   3733  40    technician  married secondary      no     257     yes   no   unknown  16   may 2008
## 3734   3734  43   blue-collar  married   unknown      no      91     yes   no   unknown  16   may 2008
## 3735   3735  26   blue-collar   single   primary      no     102     yes   no   unknown  16   may 2008
## 3736   3736  29    management  married  tertiary      no       1     yes  yes   unknown  16   may 2008
## 3737   3737  30      services   single secondary      no     484     yes   no   unknown  16   may 2008
## 3738   3738  39    management  married  tertiary      no       0     yes  yes   unknown  16   may 2008
## 3739   3739  51   blue-collar  married   primary      no     196     yes   no   unknown  16   may 2008
## 3740   3740  58        admin.  married   primary      no     879     yes   no   unknown  16   may 2008
## 3741   3741  44  entrepreneur  married  tertiary      no    3689     yes   no   unknown  16   may 2008
## 3742   3742  49    technician  married secondary      no    1269     yes   no   unknown  16   may 2008
## 3743   3743  30        admin.  married secondary      no      67     yes   no   unknown  16   may 2008
## 3744   3744  38   blue-collar  married secondary      no     961     yes   no   unknown  16   may 2008
## 3745   3745  40      services  married secondary      no     181     yes   no   unknown  16   may 2008
## 3746   3746  34  entrepreneur  married  tertiary      no     355     yes   no   unknown  16   may 2008
## 3747   3747  41    management  married  tertiary      no       0      no  yes   unknown  16   may 2008
## 3748   3748  37    management   single  tertiary      no     499     yes   no   unknown  16   may 2008
## 3749   3749  32      services divorced secondary      no    -115     yes   no   unknown  16   may 2008
## 3750   3750  31   blue-collar  married secondary      no      92     yes   no   unknown  16   may 2008
## 3751   3751  38   blue-collar   single   unknown      no    1146     yes   no   unknown  16   may 2008
## 3752   3752  34 self-employed  married  tertiary      no    1029     yes  yes   unknown  16   may 2008
## 3753   3753  42        admin.  married secondary      no     534     yes   no   unknown  16   may 2008
## 3754   3754  27      services  married secondary      no      15     yes   no   unknown  16   may 2008
## 3755   3755  35      services  married secondary      no    1053     yes   no   unknown  16   may 2008
## 3756   3756  43        admin.   single secondary      no       6      no   no   unknown  16   may 2008
## 3757   3757  29      services   single secondary      no    -142     yes   no   unknown  16   may 2008
## 3758   3758  33      services divorced secondary      no       2     yes   no   unknown  16   may 2008
## 3759   3759  57       retired divorced secondary      no      70     yes   no   unknown  16   may 2008
## 3760   3760  50  entrepreneur  married secondary      no     556     yes   no   unknown  16   may 2008
## 3761   3761  28      services   single secondary      no      45     yes   no   unknown  16   may 2008
## 3762   3762  45   blue-collar divorced secondary      no       9     yes   no   unknown  16   may 2008
## 3763   3763  33   blue-collar divorced secondary      no    -131     yes   no   unknown  16   may 2008
## 3764   3764  24   blue-collar  married secondary      no     142     yes  yes   unknown  16   may 2008
## 3765   3765  34    technician   single secondary      no       0     yes  yes   unknown  16   may 2008
## 3766   3766  23        admin.  married  tertiary      no       2     yes   no   unknown  16   may 2008
## 3767   3767  59       retired  married   primary      no     646     yes   no   unknown  16   may 2008
## 3768   3768  40        admin.   single secondary      no     739     yes   no   unknown  16   may 2008
## 3769   3769  44   blue-collar  married   primary      no    1511     yes   no   unknown  16   may 2008
## 3770   3770  33   blue-collar  married secondary      no      58      no   no   unknown  16   may 2008
## 3771   3771  29        admin.   single secondary      no     163     yes  yes   unknown  16   may 2008
## 3772   3772  39   blue-collar  married   primary      no     385     yes   no   unknown  16   may 2008
## 3773   3773  36    management divorced  tertiary      no    1343     yes  yes   unknown  16   may 2008
## 3774   3774  34      services divorced secondary      no     169     yes   no   unknown  16   may 2008
## 3775   3775  35   blue-collar  married secondary      no    -613     yes   no   unknown  16   may 2008
## 3776   3776  47      services  married   primary      no    1496     yes   no   unknown  16   may 2008
## 3777   3777  40   blue-collar  married secondary      no     580     yes   no   unknown  16   may 2008
## 3778   3778  30    technician  married secondary      no    -306     yes  yes   unknown  16   may 2008
## 3779   3779  27    management  married secondary      no     -41     yes   no   unknown  16   may 2008
## 3780   3780  40        admin. divorced secondary      no     783     yes  yes   unknown  16   may 2008
## 3781   3781  26   blue-collar divorced secondary      no     241     yes   no   unknown  16   may 2008
## 3782   3782  46    management  married  tertiary      no     245     yes   no   unknown  16   may 2008
## 3783   3783  43    management  married secondary      no     -26     yes   no   unknown  16   may 2008
## 3784   3784  36    technician   single  tertiary      no     705     yes   no   unknown  16   may 2008
## 3785   3785  32   blue-collar  married secondary      no      23     yes   no   unknown  16   may 2008
## 3786   3786  47   blue-collar divorced secondary      no     380     yes   no   unknown  16   may 2008
## 3787   3787  29   blue-collar   single secondary      no    4574     yes   no   unknown  16   may 2008
## 3788   3788  36    technician  married  tertiary      no     183     yes   no   unknown  16   may 2008
## 3789   3789  33   blue-collar   single secondary      no     272     yes   no   unknown  16   may 2008
## 3790   3790  57        admin.  married secondary      no    4168     yes  yes   unknown  16   may 2008
## 3791   3791  30    technician   single secondary      no     677     yes   no   unknown  16   may 2008
## 3792   3792  59        admin. divorced secondary      no     174     yes   no   unknown  16   may 2008
## 3793   3793  32   blue-collar  married   primary      no    1877     yes   no   unknown  16   may 2008
## 3794   3794  56       retired  married secondary      no    3690     yes  yes   unknown  16   may 2008
## 3795   3795  25   blue-collar  married secondary      no     109     yes   no   unknown  16   may 2008
## 3796   3796  30   blue-collar   single   unknown      no     194     yes   no   unknown  16   may 2008
## 3797   3797  32   blue-collar   single secondary      no       8     yes   no   unknown  16   may 2008
## 3798   3798  30        admin.  married secondary      no      40     yes  yes   unknown  16   may 2008
## 3799   3799  45   blue-collar  married secondary      no   -1400     yes   no   unknown  16   may 2008
## 3800   3800  47   blue-collar  married secondary      no    -656     yes   no   unknown  16   may 2008
## 3801   3801  25    technician   single secondary      no    1400     yes  yes   unknown  16   may 2008
## 3802   3802  28   blue-collar  married   primary      no     507     yes   no   unknown  16   may 2008
## 3803   3803  30   blue-collar   single secondary      no      75     yes   no   unknown  16   may 2008
## 3804   3804  28        admin.  married  tertiary      no     364     yes   no   unknown  16   may 2008
## 3805   3805  27    technician   single secondary      no    1742     yes   no   unknown  16   may 2008
## 3806   3806  32   blue-collar  married secondary      no    1197     yes  yes   unknown  16   may 2008
## 3807   3807  32 self-employed   single  tertiary      no   12269      no   no   unknown  16   may 2008
## 3808   3808  40 self-employed  married  tertiary      no    1126     yes   no   unknown  16   may 2008
## 3809   3809  29   blue-collar   single   primary      no     105     yes   no   unknown  16   may 2008
## 3810   3810  38        admin.  married secondary      no    -650      no   no   unknown  16   may 2008
## 3811   3811  37   blue-collar   single   primary      no     117     yes   no   unknown  16   may 2008
## 3812   3812  22        admin.   single secondary      no     118     yes   no   unknown  16   may 2008
## 3813   3813  23        admin.   single secondary      no     178     yes   no   unknown  16   may 2008
## 3814   3814  30 self-employed   single secondary      no     299     yes   no   unknown  16   may 2008
## 3815   3815  27   blue-collar   single   primary      no       0     yes   no   unknown  16   may 2008
## 3816   3816  31        admin.  married secondary      no       5      no   no   unknown  16   may 2008
## 3817   3817  26   blue-collar   single secondary      no      65      no   no   unknown  16   may 2008
## 3818   3818  36        admin. divorced secondary      no     246     yes   no   unknown  16   may 2008
## 3819   3819  29   blue-collar   single secondary      no    1166     yes   no   unknown  16   may 2008
## 3820   3820  37      services divorced secondary      no      49     yes   no   unknown  16   may 2008
## 3821   3821  39   blue-collar  married   primary      no      95     yes   no   unknown  16   may 2008
## 3822   3822  38    unemployed  married   primary      no     113     yes   no   unknown  16   may 2008
## 3823   3823  27  entrepreneur  married secondary      no     554     yes   no   unknown  16   may 2008
## 3824   3824  58       retired  married   primary      no     269     yes   no   unknown  16   may 2008
## 3825   3825  36   blue-collar  married secondary      no      63     yes   no   unknown  16   may 2008
## 3826   3826  24      services   single secondary      no    -248     yes   no   unknown  16   may 2008
## 3827   3827  25      services   single secondary      no      32     yes   no   unknown  16   may 2008
## 3828   3828  43    management  married secondary      no     452     yes   no   unknown  16   may 2008
## 3829   3829  38   blue-collar  married   primary      no     467     yes   no   unknown  16   may 2008
## 3830   3830  40   blue-collar  married   primary      no    1758     yes   no   unknown  16   may 2008
## 3831   3831  33   blue-collar   single secondary      no    -416     yes   no   unknown  16   may 2008
## 3832   3832  35    technician  married secondary      no     523     yes  yes   unknown  16   may 2008
## 3833   3833  46   blue-collar  married   primary      no    2499     yes   no   unknown  16   may 2008
## 3834   3834  30    technician   single  tertiary      no     236     yes   no   unknown  16   may 2008
## 3835   3835  24    technician   single secondary      no    3926     yes   no   unknown  16   may 2008
## 3836   3836  24    technician   single secondary      no     409     yes   no   unknown  16   may 2008
## 3837   3837  45    management  married  tertiary      no     876      no   no   unknown  16   may 2008
## 3838   3838  45   blue-collar  married   primary      no    1163      no   no   unknown  16   may 2008
## 3839   3839  53    technician   single secondary      no     708     yes   no   unknown  16   may 2008
## 3840   3840  34    technician   single  tertiary      no     586     yes   no   unknown  16   may 2008
## 3841   3841  24   blue-collar  married   primary      no     656     yes   no   unknown  16   may 2008
## 3842   3842  57     housemaid  married   primary      no     260     yes   no   unknown  16   may 2008
## 3843   3843  55   blue-collar  married   primary      no     571     yes   no   unknown  16   may 2008
## 3844   3844  52    technician   single secondary      no      36     yes   no   unknown  16   may 2008
## 3845   3845  54    technician divorced secondary      no       0     yes   no   unknown  16   may 2008
## 3846   3846  29   blue-collar   single   primary      no     -63     yes   no   unknown  16   may 2008
## 3847   3847  23      services   single secondary      no      91     yes   no   unknown  16   may 2008
## 3848   3848  24      services   single secondary      no       0      no   no   unknown  16   may 2008
## 3849   3849  59   blue-collar  married secondary      no     169     yes   no   unknown  16   may 2008
## 3850   3850  37   blue-collar   single   unknown      no    2188      no   no   unknown  16   may 2008
## 3851   3851  40   blue-collar  married secondary      no    2073     yes   no   unknown  16   may 2008
## 3852   3852  54    management divorced  tertiary      no   29887     yes   no   unknown  16   may 2008
## 3853   3853  35   blue-collar  married secondary      no      53     yes   no   unknown  16   may 2008
## 3854   3854  56     housemaid  married   primary      no      82      no   no   unknown  16   may 2008
## 3855   3855  28    technician  married secondary      no      58      no   no   unknown  16   may 2008
## 3856   3856  32    management   single secondary      no     916     yes   no   unknown  16   may 2008
## 3857   3857  40    management divorced  tertiary      no      37     yes   no   unknown  16   may 2008
## 3858   3858  32   blue-collar   single   primary      no     100     yes   no   unknown  16   may 2008
## 3859   3859  41      services  married   primary      no     124     yes   no   unknown  16   may 2008
## 3860   3860  55    management  married   primary      no      19     yes   no   unknown  16   may 2008
## 3861   3861  52    technician  married secondary      no     420      no   no   unknown  16   may 2008
## 3862   3862  58    technician divorced secondary      no     906     yes  yes   unknown  16   may 2008
## 3863   3863  29    unemployed   single  tertiary      no       0     yes  yes   unknown  16   may 2008
## 3864   3864  44   blue-collar divorced   unknown      no     532      no   no   unknown  16   may 2008
## 3865   3865  53   blue-collar  married   primary      no     634     yes   no   unknown  16   may 2008
## 3866   3866  44      services  married secondary      no       0     yes  yes   unknown  16   may 2008
## 3867   3867  41        admin.  married secondary      no     338     yes   no   unknown  16   may 2008
## 3868   3868  44        admin.  married secondary      no       0     yes  yes   unknown  16   may 2008
## 3869   3869  38    management  married  tertiary      no    2724     yes   no   unknown  16   may 2008
## 3870   3870  27    management   single  tertiary      no     -98     yes  yes   unknown  16   may 2008
## 3871   3871  44        admin.  married secondary      no      73     yes   no   unknown  16   may 2008
## 3872   3872  45   blue-collar   single secondary      no     636     yes   no   unknown  16   may 2008
## 3873   3873  30   blue-collar   single secondary      no     132     yes   no   unknown  16   may 2008
## 3874   3874  47    technician  married  tertiary      no     282     yes   no   unknown  16   may 2008
## 3875   3875  54  entrepreneur  married   primary      no    3343     yes  yes   unknown  16   may 2008
## 3876   3876  29    technician   single secondary      no    -166     yes   no   unknown  16   may 2008
## 3877   3877  50        admin. divorced secondary      no     363     yes   no   unknown  16   may 2008
## 3878   3878  32   blue-collar   single secondary      no      29      no   no   unknown  16   may 2008
## 3879   3879  57  entrepreneur  married  tertiary     yes    -524     yes   no   unknown  16   may 2008
## 3880   3880  51   blue-collar  married   primary      no    1194     yes   no   unknown  16   may 2008
## 3881   3881  32        admin.   single secondary      no     422     yes   no   unknown  16   may 2008
## 3882   3882  27    technician   single  tertiary      no    3706     yes   no   unknown  16   may 2008
## 3883   3883  41    unemployed  married secondary      no     356     yes   no   unknown  16   may 2008
## 3884   3884  53    technician  married secondary      no      31     yes   no   unknown  16   may 2008
## 3885   3885  29 self-employed   single secondary      no     272     yes   no   unknown  16   may 2008
## 3886   3886  28    management  married  tertiary      no     103     yes   no   unknown  16   may 2008
## 3887   3887  27    management   single  tertiary     yes    -308     yes   no   unknown  16   may 2008
## 3888   3888  49   blue-collar  married secondary      no      16     yes   no   unknown  16   may 2008
## 3889   3889  44   blue-collar  married   primary      no    1485     yes   no   unknown  16   may 2008
## 3890   3890  32  entrepreneur   single  tertiary      no       1     yes  yes   unknown  16   may 2008
## 3891   3891  56       retired  married   unknown      no    4391     yes   no   unknown  16   may 2008
## 3892   3892  34   blue-collar   single   primary      no      85      no   no   unknown  16   may 2008
## 3893   3893  43      services  married   primary      no     822     yes   no   unknown  16   may 2008
## 3894   3894  41    management divorced  tertiary      no     647     yes   no   unknown  16   may 2008
## 3895   3895  41    management  married  tertiary      no     223     yes   no   unknown  16   may 2008
## 3896   3896  47   blue-collar  married   primary      no     242     yes   no   unknown  16   may 2008
## 3897   3897  33   blue-collar  married secondary      no      64      no   no   unknown  16   may 2008
## 3898   3898  47      services  married secondary      no    2597     yes   no   unknown  16   may 2008
## 3899   3899  46    management divorced  tertiary      no     770     yes   no   unknown  16   may 2008
## 3900   3900  46    technician  married secondary      no    4956     yes   no   unknown  16   may 2008
## 3901   3901  30        admin.  married secondary      no     122     yes   no   unknown  16   may 2008
## 3902   3902  41    technician   single secondary      no      28      no   no   unknown  16   may 2008
## 3903   3903  30    technician  married secondary      no    1011     yes   no   unknown  16   may 2008
## 3904   3904  56       retired divorced secondary      no    4166     yes   no   unknown  16   may 2008
## 3905   3905  40    technician  married   primary      no    6110     yes   no   unknown  16   may 2008
## 3906   3906  47      services  married secondary      no     837     yes  yes   unknown  16   may 2008
## 3907   3907  36    management   single  tertiary      no     146     yes   no   unknown  16   may 2008
## 3908   3908  60       retired  married   primary      no     458     yes   no   unknown  16   may 2008
## 3909   3909  34        admin.  married secondary      no     641     yes  yes   unknown  16   may 2008
## 3910   3910  44 self-employed  married secondary      no    1310     yes   no   unknown  16   may 2008
## 3911   3911  29    technician  married secondary      no     782     yes   no   unknown  16   may 2008
## 3912   3912  48   blue-collar  married secondary      no     478     yes  yes   unknown  16   may 2008
## 3913   3913  55      services  married   unknown      no     -45     yes   no   unknown  16   may 2008
## 3914   3914  60    management  married  tertiary      no      36     yes   no   unknown  16   may 2008
## 3915   3915  29    management   single  tertiary      no       0      no   no   unknown  16   may 2008
## 3916   3916  30      services   single  tertiary      no     136     yes  yes   unknown  16   may 2008
## 3917   3917  35        admin.   single   primary      no       8     yes   no   unknown  16   may 2008
## 3918   3918  37      services   single secondary      no     934     yes   no   unknown  16   may 2008
## 3919   3919  42   blue-collar  married secondary      no     314     yes  yes   unknown  16   may 2008
## 3920   3920  34    technician  married secondary      no     978     yes   no   unknown  16   may 2008
## 3921   3921  50    management   single  tertiary      no     567     yes   no   unknown  16   may 2008
## 3922   3922  27      services   single secondary      no     194     yes   no   unknown  16   may 2008
## 3923   3923  45    technician   single  tertiary      no    4537     yes   no   unknown  16   may 2008
## 3924   3924  50    management divorced  tertiary      no     318     yes   no   unknown  16   may 2008
## 3925   3925  43    technician  married secondary      no      17     yes   no   unknown  16   may 2008
## 3926   3926  32     housemaid divorced secondary      no     715     yes  yes   unknown  16   may 2008
## 3927   3927  55    management   single  tertiary      no    1464     yes   no   unknown  16   may 2008
## 3928   3928  40      services   single secondary      no     -61     yes  yes   unknown  16   may 2008
## 3929   3929  56  entrepreneur  married  tertiary      no    1297     yes   no   unknown  16   may 2008
## 3930   3930  21        admin.   single secondary      no     325     yes   no   unknown  16   may 2008
## 3931   3931  27    technician  married  tertiary      no     276      no   no   unknown  16   may 2008
## 3932   3932  24        admin.   single secondary      no     770     yes   no   unknown  16   may 2008
## 3933   3933  25    technician   single secondary      no       2     yes  yes   unknown  16   may 2008
## 3934   3934  41   blue-collar  married   primary      no     208     yes   no   unknown  16   may 2008
## 3935   3935  49    unemployed divorced secondary      no     495     yes   no   unknown  16   may 2008
## 3936   3936  44   blue-collar  married  tertiary      no    2185     yes   no   unknown  16   may 2008
## 3937   3937  42   blue-collar  married secondary      no     351     yes   no   unknown  16   may 2008
## 3938   3938  45   blue-collar  married   primary      no      71     yes   no   unknown  16   may 2008
## 3939   3939  48      services  married   unknown      no    1155     yes   no   unknown  16   may 2008
## 3940   3940  51    technician  married secondary      no     349     yes   no   unknown  16   may 2008
## 3941   3941  33    technician  married secondary      no     153     yes   no   unknown  16   may 2008
## 3942   3942  32   blue-collar  married   primary      no     244     yes   no   unknown  16   may 2008
## 3943   3943  41    technician  married secondary      no     493     yes   no   unknown  16   may 2008
## 3944   3944  29      services  married  tertiary      no      62     yes  yes   unknown  16   may 2008
## 3945   3945  49    technician divorced  tertiary      no     874     yes   no   unknown  16   may 2008
## 3946   3946  49   blue-collar divorced secondary     yes     259      no   no   unknown  16   may 2008
## 3947   3947  25        admin.   single secondary      no     304      no   no   unknown  16   may 2008
## 3948   3948  33   blue-collar   single secondary      no     371     yes   no   unknown  16   may 2008
## 3949   3949  50   blue-collar  married   primary      no     231     yes   no   unknown  16   may 2008
## 3950   3950  50        admin.  married secondary      no    1906      no   no   unknown  16   may 2008
## 3951   3951  40    management   single secondary      no     192     yes   no   unknown  16   may 2008
## 3952   3952  32   blue-collar  married   primary      no     158     yes   no   unknown  16   may 2008
## 3953   3953  43   blue-collar divorced   primary      no     -57     yes   no   unknown  16   may 2008
## 3954   3954  24       retired   single secondary      no     366      no  yes   unknown  16   may 2008
## 3955   3955  49   blue-collar  married   primary      no     327     yes   no   unknown  16   may 2008
## 3956   3956  36    management  married  tertiary      no    1125     yes  yes   unknown  16   may 2008
## 3957   3957  42        admin.  married   unknown      no     642     yes  yes   unknown  16   may 2008
## 3958   3958  31        admin.   single secondary      no     -48     yes   no   unknown  16   may 2008
## 3959   3959  30    technician   single secondary      no     298     yes   no   unknown  16   may 2008
## 3960   3960  46    technician  married  tertiary      no    2207     yes   no   unknown  16   may 2008
## 3961   3961  35   blue-collar   single secondary      no      88     yes   no   unknown  16   may 2008
## 3962   3962  44        admin.  married secondary      no    2687     yes   no   unknown  16   may 2008
## 3963   3963  33    management  married  tertiary      no     307      no   no   unknown  16   may 2008
## 3964   3964  42   blue-collar  married   primary     yes     398     yes   no   unknown  16   may 2008
## 3965   3965  39      services   single secondary      no    -388     yes   no   unknown  16   may 2008
## 3966   3966  41   blue-collar   single   primary      no    1649     yes   no   unknown  16   may 2008
## 3967   3967  58   blue-collar  married secondary      no     886      no   no   unknown  16   may 2008
## 3968   3968  40   blue-collar  married secondary      no    1161     yes  yes   unknown  16   may 2008
## 3969   3969  37        admin.  married secondary      no     281     yes   no   unknown  16   may 2008
## 3970   3970  45   blue-collar  married   primary      no     137     yes  yes   unknown  16   may 2008
## 3971   3971  49    management  married   primary      no     267     yes   no   unknown  16   may 2008
## 3972   3972  35   blue-collar  married   primary      no     767     yes   no   unknown  16   may 2008
## 3973   3973  28   blue-collar   single secondary      no    1112     yes   no   unknown  16   may 2008
## 3974   3974  32    technician   single  tertiary      no     192     yes   no   unknown  16   may 2008
## 3975   3975  45 self-employed  married secondary      no    1113     yes   no   unknown  16   may 2008
## 3976   3976  44    technician   single secondary      no     696     yes   no   unknown  16   may 2008
## 3977   3977  55   blue-collar  married   primary      no    -268     yes   no   unknown  16   may 2008
## 3978   3978  37   blue-collar   single secondary      no     197     yes   no   unknown  16   may 2008
## 3979   3979  28      services   single secondary      no     317     yes   no   unknown  16   may 2008
## 3980   3980  43        admin.   single  tertiary      no     329     yes   no   unknown  16   may 2008
## 3981   3981  35   blue-collar   single secondary      no     510     yes   no   unknown  16   may 2008
## 3982   3982  30    management   single  tertiary      no       5      no   no   unknown  16   may 2008
## 3983   3983  54    management   single  tertiary      no    4393     yes   no   unknown  16   may 2008
## 3984   3984  34    management divorced  tertiary      no     488     yes   no   unknown  16   may 2008
## 3985   3985  30      services   single secondary      no     442     yes   no   unknown  16   may 2008
## 3986   3986  46       unknown  married   unknown      no     300     yes   no   unknown  16   may 2008
## 3987   3987  52   blue-collar  married   primary      no    1007     yes   no   unknown  16   may 2008
## 3988   3988  44   blue-collar  married   primary      no     195     yes   no   unknown  16   may 2008
## 3989   3989  36   blue-collar  married secondary      no     513     yes   no   unknown  16   may 2008
## 3990   3990  44    technician divorced secondary      no     399     yes   no   unknown  16   may 2008
## 3991   3991  44   blue-collar  married   primary      no      12     yes   no   unknown  16   may 2008
## 3992   3992  24   blue-collar   single secondary      no      77     yes   no   unknown  16   may 2008
## 3993   3993  56   blue-collar  married   primary      no    8318     yes   no   unknown  16   may 2008
## 3994   3994  41   blue-collar divorced secondary      no    -104     yes   no   unknown  16   may 2008
## 3995   3995  51    technician  married  tertiary      no       0     yes   no   unknown  16   may 2008
## 3996   3996  53   blue-collar  married secondary      no       2     yes   no   unknown  16   may 2008
## 3997   3997  41   blue-collar   single   primary      no       0     yes   no   unknown  16   may 2008
## 3998   3998  26   blue-collar   single   primary      no    -579     yes   no   unknown  16   may 2008
## 3999   3999  53  entrepreneur  married  tertiary      no    2884     yes   no   unknown  16   may 2008
## 4000   4000  30    technician   single secondary      no     863     yes   no   unknown  16   may 2008
## 4001   4001  27        admin.   single   unknown      no      56     yes   no   unknown  16   may 2008
## 4002   4002  32      services   single secondary      no     358     yes   no   unknown  16   may 2008
## 4003   4003  40   blue-collar  married secondary      no       0     yes   no   unknown  16   may 2008
## 4004   4004  55    technician  married secondary      no    2055     yes   no   unknown  16   may 2008
## 4005   4005  35      services   single secondary      no     568     yes   no   unknown  16   may 2008
## 4006   4006  32    management   single secondary      no       0     yes  yes   unknown  16   may 2008
## 4007   4007  57   blue-collar  married   unknown      no      97     yes   no   unknown  16   may 2008
## 4008   4008  32   blue-collar  married   primary      no     217     yes   no   unknown  16   may 2008
## 4009   4009  55       unknown  married  tertiary      no       0      no   no   unknown  16   may 2008
## 4010   4010  43      services  married secondary      no    3608     yes   no   unknown  16   may 2008
## 4011   4011  42   blue-collar  married secondary      no     388     yes  yes   unknown  16   may 2008
## 4012   4012  27    management   single  tertiary     yes       0     yes   no   unknown  16   may 2008
## 4013   4013  36      services  married secondary      no     279      no   no   unknown  16   may 2008
## 4014   4014  32        admin.  married secondary      no     193     yes   no   unknown  16   may 2008
## 4015   4015  53    technician divorced secondary      no     751     yes   no   unknown  16   may 2008
## 4016   4016  34   blue-collar  married secondary      no     305     yes   no   unknown  16   may 2008
## 4017   4017  23   blue-collar   single secondary      no     105     yes   no   unknown  16   may 2008
## 4018   4018  31    management   single  tertiary      no     548     yes   no   unknown  16   may 2008
## 4019   4019  46      services  married secondary      no     271     yes   no   unknown  16   may 2008
## 4020   4020  31      services  married secondary      no     246     yes   no   unknown  16   may 2008
## 4021   4021  42 self-employed  married  tertiary      no    1932     yes   no   unknown  16   may 2008
## 4022   4022  52 self-employed  married secondary      no    1066     yes   no   unknown  16   may 2008
## 4023   4023  38   blue-collar  married   primary      no    -326     yes   no   unknown  16   may 2008
## 4024   4024  38   blue-collar   single   primary      no    1465     yes   no   unknown  16   may 2008
## 4025   4025  60    unemployed  married   primary      no      26     yes   no   unknown  16   may 2008
## 4026   4026  42    management   single  tertiary      no   10561      no   no   unknown  16   may 2008
## 4027   4027  30   blue-collar  married secondary      no      68     yes  yes   unknown  16   may 2008
## 4028   4028  53    technician divorced  tertiary      no     647     yes   no   unknown  16   may 2008
## 4029   4029  35        admin.   single secondary      no     368     yes   no   unknown  16   may 2008
## 4030   4030  45        admin.  married secondary      no    -183     yes   no   unknown  16   may 2008
## 4031   4031  57       retired  married   primary      no      70     yes  yes   unknown  16   may 2008
## 4032   4032  41    technician  married   primary      no     141     yes   no   unknown  16   may 2008
## 4033   4033  44   blue-collar  married   primary      no      75      no   no   unknown  16   may 2008
## 4034   4034  56   blue-collar  married   unknown      no      22     yes   no   unknown  16   may 2008
## 4035   4035  46      services  married secondary      no       9      no   no   unknown  16   may 2008
## 4036   4036  34   blue-collar  married   primary      no     695     yes  yes   unknown  16   may 2008
## 4037   4037  51   blue-collar divorced   primary      no      83     yes   no   unknown  16   may 2008
## 4038   4038  27      services   single secondary      no     -20      no   no   unknown  16   may 2008
## 4039   4039  31 self-employed   single secondary      no     532     yes   no   unknown  16   may 2008
## 4040   4040  51    management  married  tertiary      no       0     yes   no   unknown  16   may 2008
## 4041   4041  25    management   single  tertiary      no      99     yes  yes   unknown  16   may 2008
## 4042   4042  48    management  married   unknown      no      54     yes   no   unknown  16   may 2008
## 4043   4043  37    management   single secondary      no     792     yes   no   unknown  16   may 2008
## 4044   4044  35   blue-collar  married   primary      no     378     yes   no   unknown  16   may 2008
## 4045   4045  58 self-employed  married  tertiary      no    8014     yes   no   unknown  19   may 2008
## 4046   4046  47   blue-collar  married   unknown      no     584     yes   no   unknown  19   may 2008
## 4047   4047  58       retired  married   primary      no     331     yes   no   unknown  19   may 2008
## 4048   4048  36    management  married secondary      no     122     yes   no   unknown  19   may 2008
## 4049   4049  38   blue-collar  married secondary      no     660     yes  yes   unknown  19   may 2008
## 4050   4050  27        admin.   single secondary      no     276     yes   no   unknown  19   may 2008
## 4051   4051  44   blue-collar  married   primary      no     -14     yes  yes   unknown  19   may 2008
## 4052   4052  47   blue-collar   single secondary      no      15     yes   no   unknown  19   may 2008
## 4053   4053  26        admin.   single secondary      no    -326     yes   no   unknown  19   may 2008
## 4054   4054  29      services   single secondary      no    2099     yes  yes   unknown  19   may 2008
## 4055   4055  60    management divorced  tertiary      no    2589     yes   no   unknown  19   may 2008
## 4056   4056  37  entrepreneur   single secondary      no     654      no   no   unknown  19   may 2008
## 4057   4057  35   blue-collar  married secondary      no     474     yes   no   unknown  19   may 2008
## 4058   4058  44   blue-collar  married secondary      no     294     yes   no   unknown  19   may 2008
## 4059   4059  50    management divorced   primary      no      -6     yes   no   unknown  19   may 2008
## 4060   4060  41   blue-collar  married   primary      no     865      no  yes   unknown  19   may 2008
## 4061   4061  26    technician divorced secondary      no     379     yes  yes   unknown  19   may 2008
## 4062   4062  43    management  married   primary      no    8167     yes   no   unknown  19   may 2008
## 4063   4063  46    management  married   primary      no     357     yes  yes   unknown  19   may 2008
## 4064   4064  54      services  married secondary      no    2431     yes   no   unknown  19   may 2008
## 4065   4065  46   blue-collar  married  tertiary      no    1497     yes   no   unknown  19   may 2008
## 4066   4066  46   blue-collar  married   primary      no    7934     yes   no   unknown  19   may 2008
## 4067   4067  55   blue-collar  married secondary      no    1261      no   no   unknown  19   may 2008
## 4068   4068  45   blue-collar  married secondary      no    1124     yes   no   unknown  19   may 2008
## 4069   4069  58       retired  married   primary      no     196     yes   no   unknown  19   may 2008
## 4070   4070  48    unemployed  married  tertiary      no    -471     yes   no   unknown  19   may 2008
## 4071   4071  38      services  married secondary      no     497     yes  yes   unknown  19   may 2008
## 4072   4072  57      services divorced   primary      no    1920      no   no   unknown  19   may 2008
## 4073   4073  54   blue-collar divorced   primary      no    8180      no   no   unknown  19   may 2008
## 4074   4074  40    management   single  tertiary      no    2784     yes   no   unknown  19   may 2008
## 4075   4075  44      services  married secondary      no     556      no   no   unknown  19   may 2008
## 4076   4076  55    technician  married secondary      no     517     yes  yes   unknown  19   may 2008
## 4077   4077  40   blue-collar   single   unknown      no    -154     yes  yes   unknown  19   may 2008
## 4078   4078  42    management divorced  tertiary      no       0      no   no   unknown  19   may 2008
## 4079   4079  48    technician  married secondary      no     522     yes   no   unknown  19   may 2008
## 4080   4080  52        admin. divorced secondary      no    -342      no   no   unknown  19   may 2008
## 4081   4081  31   blue-collar  married secondary      no      43     yes   no   unknown  19   may 2008
## 4082   4082  60        admin.  married secondary      no   12210     yes   no   unknown  19   may 2008
## 4083   4083  51      services  married   primary      no    8806     yes   no   unknown  19   may 2008
## 4084   4084  50   blue-collar divorced secondary      no    2402     yes   no   unknown  19   may 2008
## 4085   4085  44  entrepreneur  married secondary     yes    -848     yes   no   unknown  19   may 2008
## 4086   4086  33        admin.  married secondary      no       0      no   no   unknown  19   may 2008
## 4087   4087  43    technician  married secondary      no     674     yes  yes   unknown  19   may 2008
## 4088   4088  46      services divorced secondary      no     778     yes   no   unknown  19   may 2008
## 4089   4089  43      services  married secondary      no     384     yes  yes   unknown  19   may 2008
## 4090   4090  50      services divorced secondary      no     256     yes   no   unknown  19   may 2008
## 4091   4091  41        admin.   single secondary      no    1020     yes   no   unknown  19   may 2008
## 4092   4092  50      services  married secondary      no    1463     yes   no   unknown  19   may 2008
## 4093   4093  50      services divorced secondary      no     761     yes   no   unknown  19   may 2008
## 4094   4094  40        admin.  married secondary      no    1380     yes   no   unknown  19   may 2008
## 4095   4095  30   blue-collar   single   primary      no      71     yes   no   unknown  19   may 2008
## 4096   4096  44        admin.  married secondary     yes   -1249     yes  yes   unknown  19   may 2008
## 4097   4097  51    technician   single secondary      no    4089     yes   no   unknown  19   may 2008
## 4098   4098  40   blue-collar  married   primary      no    3736     yes   no   unknown  19   may 2008
## 4099   4099  38   blue-collar  married   primary      no    2407     yes   no   unknown  19   may 2008
## 4100   4100  52    technician  married secondary      no    1781     yes   no   unknown  19   may 2008
## 4101   4101  49    technician  married secondary      no    4667     yes   no   unknown  19   may 2008
## 4102   4102  44        admin. divorced secondary      no       2     yes   no   unknown  19   may 2008
## 4103   4103  39        admin.  married  tertiary      no     259     yes   no   unknown  19   may 2008
## 4104   4104  43        admin.   single secondary      no     445     yes   no   unknown  19   may 2008
## 4105   4105  32      services  married secondary      no     132     yes  yes   unknown  19   may 2008
## 4106   4106  55    management divorced   unknown      no       2     yes   no   unknown  19   may 2008
## 4107   4107  55      services  married secondary      no     283     yes   no   unknown  19   may 2008
## 4108   4108  42    management divorced secondary      no     830     yes   no   unknown  19   may 2008
## 4109   4109  26    technician   single  tertiary      no      75     yes  yes   unknown  19   may 2008
## 4110   4110  54      services  married secondary      no     158     yes   no   unknown  19   may 2008
## 4111   4111  34   blue-collar  married   primary      no      46     yes  yes   unknown  19   may 2008
## 4112   4112  46    management  married  tertiary      no    4301     yes  yes   unknown  19   may 2008
## 4113   4113  25   blue-collar   single secondary      no     815     yes   no   unknown  19   may 2008
## 4114   4114  49    management  married  tertiary      no     128     yes   no   unknown  19   may 2008
## 4115   4115  59   blue-collar divorced   primary      no     457     yes   no   unknown  19   may 2008
## 4116   4116  57    management  married   primary      no       0      no   no   unknown  19   may 2008
## 4117   4117  27    technician  married secondary      no     374     yes   no   unknown  19   may 2008
## 4118   4118  38      services  married secondary      no    3259     yes   no   unknown  19   may 2008
## 4119   4119  41      services divorced secondary      no     -19     yes   no   unknown  19   may 2008
## 4120   4120  56   blue-collar  married secondary      no     316     yes   no   unknown  19   may 2008
## 4121   4121  37   blue-collar  married secondary      no     398     yes   no   unknown  19   may 2008
## 4122   4122  32    unemployed  married secondary      no    2996     yes   no   unknown  19   may 2008
## 4123   4123  47        admin.  married secondary      no     292     yes   no   unknown  19   may 2008
## 4124   4124  57    management  married  tertiary      no    5431     yes   no   unknown  19   may 2008
## 4125   4125  38      services   single  tertiary      no     323     yes   no   unknown  19   may 2008
## 4126   4126  30   blue-collar  married secondary      no    1312     yes   no   unknown  19   may 2008
## 4127   4127  43   blue-collar  married   primary      no     953     yes   no   unknown  19   may 2008
## 4128   4128  35   blue-collar   single secondary      no       5      no   no   unknown  19   may 2008
## 4129   4129  28    technician   single secondary      no     213     yes   no   unknown  19   may 2008
## 4130   4130  38        admin.  married secondary      no     976     yes  yes   unknown  19   may 2008
## 4131   4131  45   blue-collar  married   primary      no     970     yes   no   unknown  19   may 2008
## 4132   4132  31    technician   single secondary      no      87     yes   no   unknown  19   may 2008
## 4133   4133  38    technician  married secondary      no      59     yes   no   unknown  19   may 2008
## 4134   4134  28       student   single  tertiary      no      80     yes   no   unknown  19   may 2008
## 4135   4135  40    unemployed  married   primary      no    3444     yes   no   unknown  19   may 2008
## 4136   4136  30   blue-collar  married secondary      no   12697     yes  yes   unknown  19   may 2008
## 4137   4137  47   blue-collar  married secondary      no     863     yes   no   unknown  19   may 2008
## 4138   4138  27    management   single  tertiary     yes       0     yes   no   unknown  19   may 2008
## 4139   4139  30    technician   single secondary      no      18      no   no   unknown  19   may 2008
## 4140   4140  53      services  married secondary      no      33     yes   no   unknown  19   may 2008
## 4141   4141  48   blue-collar  married   primary      no     281     yes   no   unknown  19   may 2008
## 4142   4142  35    technician   single secondary      no    -206     yes   no   unknown  19   may 2008
## 4143   4143  38      services   single secondary      no      36     yes   no   unknown  19   may 2008
## 4144   4144  32    technician  married   unknown      no    1879      no   no   unknown  19   may 2008
## 4145   4145  53   blue-collar  married   primary      no      10     yes   no   unknown  19   may 2008
## 4146   4146  25   blue-collar  married secondary      no      77     yes   no   unknown  19   may 2008
## 4147   4147  45  entrepreneur  married  tertiary      no     369     yes   no   unknown  19   may 2008
## 4148   4148  28   blue-collar   single secondary      no      43      no   no   unknown  19   may 2008
## 4149   4149  30   blue-collar  married   primary      no     392     yes   no   unknown  19   may 2008
## 4150   4150  31        admin.   single secondary      no       0      no   no   unknown  19   may 2008
## 4151   4151  42     housemaid  married   primary      no   14752      no   no   unknown  19   may 2008
## 4152   4152  60        admin.  married   unknown      no     738      no   no   unknown  19   may 2008
## 4153   4153  28       student   single  tertiary      no     836     yes   no   unknown  19   may 2008
## 4154   4154  46   blue-collar   single   primary      no    2851     yes   no   unknown  19   may 2008
## 4155   4155  40    technician  married  tertiary      no     296      no   no   unknown  19   may 2008
## 4156   4156  32   blue-collar  married   primary      no    1076     yes   no   unknown  19   may 2008
## 4157   4157  56   blue-collar  married secondary      no      25     yes   no   unknown  19   may 2008
## 4158   4158  20   blue-collar  married   primary      no    -172     yes  yes   unknown  19   may 2008
## 4159   4159  41      services   single secondary      no     197     yes   no   unknown  19   may 2008
## 4160   4160  48   blue-collar  married secondary      no    5057     yes   no   unknown  19   may 2008
## 4161   4161  49   blue-collar  married   primary      no     284     yes   no   unknown  19   may 2008
## 4162   4162  29   blue-collar   single  tertiary      no    1012     yes   no   unknown  19   may 2008
## 4163   4163  57        admin. divorced secondary      no    4378     yes   no   unknown  19   may 2008
## 4164   4164  49    technician  married secondary      no    2718      no   no   unknown  19   may 2008
## 4165   4165  42  entrepreneur   single   primary      no     103     yes   no   unknown  19   may 2008
## 4166   4166  28   blue-collar  married secondary      no    1827     yes   no   unknown  19   may 2008
## 4167   4167  31   blue-collar  married secondary      no      41     yes   no   unknown  19   may 2008
## 4168   4168  26   blue-collar  married secondary      no     484     yes   no   unknown  19   may 2008
## 4169   4169  29      services   single secondary      no     146     yes   no   unknown  19   may 2008
## 4170   4170  26    technician   single secondary      no       3     yes   no   unknown  19   may 2008
## 4171   4171  31   blue-collar   single secondary      no     259     yes   no   unknown  19   may 2008
## 4172   4172  38  entrepreneur  married secondary      no     830     yes   no   unknown  19   may 2008
## 4173   4173  45      services divorced   primary      no     242     yes   no   unknown  19   may 2008
## 4174   4174  24   blue-collar   single secondary      no       0     yes   no   unknown  19   may 2008
## 4175   4175  31        admin.   single secondary      no    6042     yes   no   unknown  19   may 2008
## 4176   4176  40   blue-collar  married secondary      no    -341     yes   no   unknown  19   may 2008
## 4177   4177  34      services divorced secondary      no     221     yes   no   unknown  19   may 2008
## 4178   4178  24    technician   single secondary      no     -46     yes   no   unknown  19   may 2008
## 4179   4179  26   blue-collar   single secondary      no      -5      no   no   unknown  19   may 2008
## 4180   4180  29    management   single  tertiary      no     617     yes   no   unknown  19   may 2008
## 4181   4181  30    management  married  tertiary      no     134     yes   no   unknown  19   may 2008
## 4182   4182  61   blue-collar  married   primary      no     625     yes   no   unknown  19   may 2008
## 4183   4183  26    management  married  tertiary      no     775      no   no   unknown  19   may 2008
## 4184   4184  31    technician   single  tertiary      no     221     yes   no   unknown  19   may 2008
## 4185   4185  28    technician   single  tertiary      no     -31     yes   no   unknown  19   may 2008
## 4186   4186  31        admin.  married secondary      no      97     yes   no   unknown  19   may 2008
## 4187   4187  52  entrepreneur divorced  tertiary      no      81     yes   no   unknown  19   may 2008
## 4188   4188  30   blue-collar   single secondary      no      16     yes   no   unknown  19   may 2008
## 4189   4189  32      services  married secondary      no     144     yes   no   unknown  19   may 2008
## 4190   4190  38    management   single  tertiary      no     889      no   no   unknown  19   may 2008
## 4191   4191  40   blue-collar  married secondary      no    -481     yes  yes   unknown  19   may 2008
## 4192   4192  38  entrepreneur  married secondary      no     680     yes   no   unknown  19   may 2008
## 4193   4193  54   blue-collar  married secondary      no    -754     yes   no   unknown  19   may 2008
## 4194   4194  42      services  married secondary      no    2993     yes   no   unknown  19   may 2008
## 4195   4195  34    technician divorced  tertiary      no     501     yes   no   unknown  19   may 2008
## 4196   4196  42    management  married  tertiary      no     365     yes   no   unknown  19   may 2008
## 4197   4197  54       retired divorced   primary      no     477     yes   no   unknown  19   may 2008
## 4198   4198  27   blue-collar  married secondary      no      72     yes   no   unknown  19   may 2008
## 4199   4199  31   blue-collar  married   primary      no    2085     yes  yes   unknown  19   may 2008
## 4200   4200  34    technician   single secondary      no     705     yes  yes   unknown  19   may 2008
## 4201   4201  31   blue-collar  married secondary      no     754     yes   no   unknown  19   may 2008
## 4202   4202  27    technician  married secondary      no     512     yes   no   unknown  19   may 2008
## 4203   4203  25   blue-collar  married secondary      no     300     yes  yes   unknown  19   may 2008
## 4204   4204  20       student   single secondary      no      67     yes   no   unknown  19   may 2008
## 4205   4205  54        admin. divorced secondary      no     912     yes   no   unknown  19   may 2008
## 4206   4206  30   blue-collar   single   unknown      no       0     yes   no   unknown  19   may 2008
## 4207   4207  33   blue-collar  married secondary      no      86     yes   no   unknown  19   may 2008
## 4208   4208  22   blue-collar   single secondary      no       0     yes   no   unknown  19   may 2008
## 4209   4209  36   blue-collar  married   unknown      no      79     yes   no   unknown  19   may 2008
## 4210   4210  44   blue-collar  married secondary      no      87     yes   no   unknown  19   may 2008
## 4211   4211  43    management  married secondary      no    3196     yes  yes   unknown  19   may 2008
## 4212   4212  44       retired  married secondary      no     181     yes   no   unknown  19   may 2008
## 4213   4213  49    management   single  tertiary      no     354     yes   no   unknown  19   may 2008
## 4214   4214  27  entrepreneur  married secondary      no     220     yes   no   unknown  19   may 2008
## 4215   4215  45   blue-collar  married   primary      no    2128     yes   no   unknown  19   may 2008
## 4216   4216  41    management  married  tertiary      no    4357     yes   no   unknown  19   may 2008
## 4217   4217  28  entrepreneur   single   unknown      no    1306     yes   no   unknown  19   may 2008
## 4218   4218  51    technician  married   unknown      no     425     yes   no   unknown  19   may 2008
## 4219   4219  49    management  married  tertiary      no      68     yes  yes   unknown  19   may 2008
## 4220   4220  42    unemployed  married secondary      no    1990     yes  yes   unknown  19   may 2008
## 4221   4221  55    technician  married secondary      no     978     yes   no   unknown  19   may 2008
## 4222   4222  41    technician   single secondary      no       0     yes  yes   unknown  19   may 2008
## 4223   4223  51    management   single  tertiary      no     824      no   no   unknown  19   may 2008
## 4224   4224  46   blue-collar  married secondary      no     679     yes   no   unknown  19   may 2008
## 4225   4225  41   blue-collar  married   primary      no     262     yes   no   unknown  19   may 2008
## 4226   4226  32   blue-collar divorced secondary      no      86      no  yes   unknown  19   may 2008
## 4227   4227  43    technician   single  tertiary      no    1017     yes   no   unknown  19   may 2008
## 4228   4228  48   blue-collar  married   primary      no     456     yes  yes   unknown  19   may 2008
## 4229   4229  52 self-employed  married secondary      no    6353     yes  yes   unknown  19   may 2008
## 4230   4230  29    technician   single secondary      no     103      no   no   unknown  19   may 2008
## 4231   4231  51        admin. divorced secondary      no     467     yes   no   unknown  19   may 2008
## 4232   4232  48   blue-collar  married secondary      no     841     yes   no   unknown  19   may 2008
## 4233   4233  34      services  married secondary      no       0     yes   no   unknown  19   may 2008
## 4234   4234  52        admin.   single secondary      no    -346     yes  yes   unknown  19   may 2008
## 4235   4235  31 self-employed  married secondary      no     157     yes   no   unknown  19   may 2008
## 4236   4236  41    technician  married secondary      no     459     yes   no   unknown  19   may 2008
## 4237   4237  40      services   single secondary      no     464     yes  yes   unknown  19   may 2008
## 4238   4238  51      services  married secondary      no    2085     yes   no   unknown  19   may 2008
## 4239   4239  42   blue-collar  married   unknown      no    1323     yes   no   unknown  19   may 2008
## 4240   4240  31   blue-collar   single secondary      no      75     yes   no   unknown  19   may 2008
## 4241   4241  34   blue-collar  married   primary      no    -288     yes   no   unknown  19   may 2008
## 4242   4242  41 self-employed  married secondary      no     713     yes   no   unknown  19   may 2008
## 4243   4243  43   blue-collar  married secondary      no    1071     yes   no   unknown  19   may 2008
## 4244   4244  54   blue-collar  married secondary      no     887     yes   no   unknown  19   may 2008
## 4245   4245  47      services  married secondary      no    -288      no   no   unknown  19   may 2008
## 4246   4246  41   blue-collar  married   primary      no    3722     yes   no   unknown  19   may 2008
## 4247   4247  40    management  married  tertiary      no       3     yes  yes   unknown  19   may 2008
## 4248   4248  23    management   single secondary      no      85     yes   no   unknown  19   may 2008
## 4249   4249  48   blue-collar  married   primary      no    6489     yes   no   unknown  19   may 2008
## 4250   4250  36        admin.   single secondary      no    3457      no   no   unknown  19   may 2008
## 4251   4251  44    management divorced  tertiary      no     409     yes   no   unknown  19   may 2008
## 4252   4252  31        admin.   single secondary      no     396     yes   no   unknown  19   may 2008
## 4253   4253  32   blue-collar  married secondary      no     101     yes   no   unknown  19   may 2008
## 4254   4254  49   blue-collar  married secondary      no     402     yes   no   unknown  19   may 2008
## 4255   4255  23   blue-collar   single secondary      no     525     yes   no   unknown  19   may 2008
## 4256   4256  41        admin.  married secondary      no    3855     yes   no   unknown  19   may 2008
## 4257   4257  52   blue-collar  married secondary      no     157     yes  yes   unknown  19   may 2008
## 4258   4258  41    management  married  tertiary      no    1897     yes   no   unknown  19   may 2008
## 4259   4259  22   blue-collar  married secondary      no      36     yes   no   unknown  19   may 2008
## 4260   4260  60   blue-collar  married secondary      no     171     yes   no   unknown  19   may 2008
## 4261   4261  60    technician  married   unknown      no     148     yes   no   unknown  19   may 2008
## 4262   4262  35    technician  married   unknown      no     208     yes   no   unknown  19   may 2008
## 4263   4263  49   blue-collar  married   primary      no    1536     yes   no   unknown  19   may 2008
## 4264   4264  32   blue-collar   single secondary      no     476     yes  yes   unknown  19   may 2008
## 4265   4265  45   blue-collar  married secondary      no      42     yes   no   unknown  19   may 2008
## 4266   4266  29    management   single  tertiary      no    -233     yes   no   unknown  19   may 2008
## 4267   4267  45    management  married  tertiary      no    1540     yes   no   unknown  19   may 2008
## 4268   4268  28    management   single  tertiary      no    3238     yes   no   unknown  19   may 2008
## 4269   4269  21       student   single   unknown      no     210     yes   no   unknown  19   may 2008
## 4270   4270  31      services   single secondary      no    1629     yes   no   unknown  19   may 2008
## 4271   4271  27        admin. divorced secondary      no     112     yes   no   unknown  19   may 2008
## 4272   4272  43      services divorced secondary      no    1040     yes   no   unknown  19   may 2008
## 4273   4273  24   blue-collar   single   unknown      no      76     yes   no   unknown  19   may 2008
## 4274   4274  28   blue-collar   single secondary      no     362     yes   no   unknown  19   may 2008
## 4275   4275  42    management divorced  tertiary      no    1116     yes   no   unknown  19   may 2008
## 4276   4276  40   blue-collar  married secondary      no    -365     yes   no   unknown  19   may 2008
## 4277   4277  42      services  married   primary      no    2567     yes   no   unknown  19   may 2008
## 4278   4278  31   blue-collar   single secondary      no      19     yes   no   unknown  19   may 2008
## 4279   4279  47   blue-collar  married   primary      no     146     yes  yes   unknown  19   may 2008
## 4280   4280  40   blue-collar divorced secondary      no     125     yes   no   unknown  19   may 2008
## 4281   4281  31        admin. divorced secondary      no      47     yes   no   unknown  19   may 2008
## 4282   4282  26   blue-collar divorced secondary      no       0     yes   no   unknown  19   may 2008
## 4283   4283  52        admin.   single   primary      no       0      no   no   unknown  19   may 2008
## 4284   4284  31   blue-collar   single  tertiary      no     462     yes  yes   unknown  19   may 2008
## 4285   4285  44    management  married  tertiary      no    4087     yes   no   unknown  19   may 2008
## 4286   4286  27    technician   single secondary      no      16      no   no   unknown  19   may 2008
## 4287   4287  41   blue-collar  married   unknown      no     665     yes   no   unknown  19   may 2008
## 4288   4288  28    management   single secondary      no     471     yes  yes   unknown  19   may 2008
## 4289   4289  27   blue-collar  married secondary      no     613     yes   no   unknown  19   may 2008
## 4290   4290  34        admin.  married secondary      no     645     yes   no   unknown  19   may 2008
## 4291   4291  44   blue-collar  married secondary      no    1087     yes   no   unknown  19   may 2008
## 4292   4292  36   blue-collar  married   primary      no    2079     yes  yes   unknown  19   may 2008
## 4293   4293  37    technician  married secondary      no    1633     yes   no   unknown  19   may 2008
## 4294   4294  27    technician   single   primary      no    1022     yes   no   unknown  19   may 2008
## 4295   4295  32   blue-collar   single secondary      no    1211     yes   no   unknown  19   may 2008
## 4296   4296  31   blue-collar  married secondary      no    9714     yes   no   unknown  19   may 2008
## 4297   4297  51    management  married  tertiary      no     642      no   no   unknown  19   may 2008
## 4298   4298  47    technician divorced secondary      no    1851     yes   no   unknown  19   may 2008
## 4299   4299  23       student   single secondary      no     405     yes   no   unknown  19   may 2008
## 4300   4300  30    management   single  tertiary      no     358     yes   no   unknown  19   may 2008
## 4301   4301  50   blue-collar  married secondary      no     170     yes  yes   unknown  19   may 2008
## 4302   4302  52      services  married secondary      no    2420     yes   no   unknown  19   may 2008
## 4303   4303  34   blue-collar   single secondary      no    1484     yes   no   unknown  19   may 2008
## 4304   4304  28  entrepreneur  married secondary      no     422     yes   no   unknown  19   may 2008
## 4305   4305  28        admin.   single secondary      no     350     yes  yes   unknown  19   may 2008
## 4306   4306  57       retired  married secondary      no     919     yes  yes   unknown  19   may 2008
## 4307   4307  31    management   single  tertiary      no     444     yes   no   unknown  19   may 2008
## 4308   4308  35    management  married  tertiary      no    1253     yes   no   unknown  19   may 2008
## 4309   4309  49  entrepreneur  married  tertiary      no     320     yes  yes   unknown  19   may 2008
## 4310   4310  32      services  married secondary      no    1066     yes   no   unknown  19   may 2008
## 4311   4311  28      services  married   unknown      no    -134     yes   no   unknown  19   may 2008
## 4312   4312  51    management   single  tertiary      no    1146     yes  yes   unknown  19   may 2008
## 4313   4313  32   blue-collar  married   primary      no     424     yes   no   unknown  19   may 2008
## 4314   4314  37    management divorced  tertiary      no     122     yes   no   unknown  19   may 2008
## 4315   4315  55   blue-collar  married secondary      no     212     yes   no   unknown  19   may 2008
## 4316   4316  27   blue-collar   single secondary      no       5     yes   no   unknown  19   may 2008
## 4317   4317  49    management   single  tertiary      no     580      no   no   unknown  19   may 2008
## 4318   4318  22   blue-collar   single secondary      no    3992     yes  yes   unknown  19   may 2008
## 4319   4319  36    technician divorced secondary      no     141     yes   no   unknown  19   may 2008
## 4320   4320  46    management divorced secondary      no     361     yes   no   unknown  19   may 2008
## 4321   4321  57   blue-collar  married secondary      no    8195     yes   no   unknown  19   may 2008
## 4322   4322  55        admin. divorced secondary      no    3524     yes   no   unknown  19   may 2008
## 4323   4323  34   blue-collar  married secondary      no    1710     yes  yes   unknown  19   may 2008
## 4324   4324  44    technician  married   primary      no     177     yes   no   unknown  19   may 2008
## 4325   4325  45    management  married  tertiary      no     199      no   no   unknown  19   may 2008
## 4326   4326  30   blue-collar  married secondary      no       0      no   no   unknown  19   may 2008
## 4327   4327  30    technician   single  tertiary      no     880     yes  yes   unknown  19   may 2008
## 4328   4328  45   blue-collar  married secondary      no     771     yes   no   unknown  19   may 2008
## 4329   4329  34   blue-collar divorced secondary      no     164     yes   no   unknown  19   may 2008
## 4330   4330  41    technician  married secondary      no     501     yes   no   unknown  19   may 2008
## 4331   4331  45    management  married   unknown      no    9051     yes   no   unknown  19   may 2008
## 4332   4332  46    technician divorced   unknown      no     103      no   no   unknown  19   may 2008
## 4333   4333  37    management  married  tertiary      no      89     yes   no   unknown  19   may 2008
## 4334   4334  45   blue-collar  married secondary      no    4111     yes   no   unknown  19   may 2008
## 4335   4335  42   blue-collar  married   primary      no     170     yes   no   unknown  19   may 2008
## 4336   4336  49   blue-collar  married secondary      no    1854     yes   no   unknown  19   may 2008
## 4337   4337  54   blue-collar  married secondary      no     233     yes   no   unknown  19   may 2008
## 4338   4338  60       retired  married secondary      no     819     yes   no   unknown  19   may 2008
## 4339   4339  24        admin.   single secondary      no    1019     yes   no   unknown  19   may 2008
## 4340   4340  43   blue-collar  married   primary      no    1147     yes  yes   unknown  19   may 2008
## 4341   4341  49    technician  married  tertiary      no     279     yes   no   unknown  19   may 2008
## 4342   4342  45   blue-collar  married   unknown      no    1263     yes   no   unknown  19   may 2008
## 4343   4343  54    technician divorced secondary      no    7449     yes   no   unknown  19   may 2008
## 4344   4344  39    management  married  tertiary      no     198     yes   no   unknown  19   may 2008
## 4345   4345  23    technician   single   unknown      no     710     yes   no   unknown  19   may 2008
## 4346   4346  48      services divorced secondary      no     858     yes   no   unknown  19   may 2008
## 4347   4347  38        admin.  married secondary      no    1344     yes  yes   unknown  19   may 2008
## 4348   4348  44 self-employed   single  tertiary      no     149     yes   no   unknown  19   may 2008
## 4349   4349  53    management   single   primary      no     208     yes   no   unknown  19   may 2008
## 4350   4350  28   blue-collar  married secondary      no     224     yes   no   unknown  19   may 2008
## 4351   4351  38    management   single  tertiary      no      91     yes   no   unknown  19   may 2008
## 4352   4352  27   blue-collar   single secondary     yes      -3     yes   no   unknown  19   may 2008
## 4353   4353  25   blue-collar  married secondary      no     316     yes  yes   unknown  19   may 2008
## 4354   4354  35        admin.  married secondary      no     846     yes  yes   unknown  19   may 2008
## 4355   4355  31   blue-collar  married   primary      no     352     yes   no   unknown  19   may 2008
## 4356   4356  40   blue-collar  married   primary      no     -22     yes   no   unknown  19   may 2008
## 4357   4357  27      services   single secondary      no    4923     yes   no   unknown  19   may 2008
## 4358   4358  53        admin.  married  tertiary     yes       6      no   no   unknown  19   may 2008
## 4359   4359  32    management divorced  tertiary      no     312     yes  yes   unknown  19   may 2008
## 4360   4360  37    technician   single secondary      no      61     yes   no   unknown  19   may 2008
## 4361   4361  37   blue-collar  married   primary      no      53     yes   no   unknown  19   may 2008
## 4362   4362  47   blue-collar  married   unknown      no    -345     yes   no   unknown  19   may 2008
## 4363   4363  36    management divorced  tertiary      no       0     yes   no   unknown  19   may 2008
## 4364   4364  52   blue-collar  married secondary      no    2231     yes  yes   unknown  19   may 2008
## 4365   4365  52      services  married   unknown      no     337     yes   no   unknown  19   may 2008
## 4366   4366  50    technician  married   unknown      no     413     yes   no   unknown  19   may 2008
## 4367   4367  45   blue-collar  married secondary      no    1345     yes   no   unknown  19   may 2008
## 4368   4368  52   blue-collar  married   primary      no     522     yes   no   unknown  19   may 2008
## 4369   4369  23      services  married   primary      no     523     yes  yes   unknown  19   may 2008
## 4370   4370  44   blue-collar  married secondary      no     261     yes   no   unknown  19   may 2008
## 4371   4371  27        admin.   single secondary      no    3776     yes   no   unknown  19   may 2008
## 4372   4372  57    technician  married secondary      no     437     yes   no   unknown  19   may 2008
## 4373   4373  48   blue-collar  married   primary      no     490     yes   no   unknown  19   may 2008
## 4374   4374  51    management  married   unknown      no    6482     yes   no   unknown  19   may 2008
## 4375   4375  53    management  married   primary      no    3544      no   no   unknown  19   may 2008
## 4376   4376  46       retired  married   primary      no       0      no   no   unknown  19   may 2008
## 4377   4377  49      services   single secondary      no     459     yes   no   unknown  19   may 2008
## 4378   4378  30    technician   single  tertiary      no    3291     yes   no   unknown  19   may 2008
## 4379   4379  41    management  married   primary      no    2592     yes   no   unknown  19   may 2008
## 4380   4380  42 self-employed  married  tertiary      no     596     yes   no   unknown  19   may 2008
## 4381   4381  34 self-employed  married secondary      no     -56     yes   no   unknown  19   may 2008
## 4382   4382  44      services  married   primary      no    1161     yes   no   unknown  19   may 2008
## 4383   4383  34   blue-collar  married   primary      no     183     yes   no   unknown  19   may 2008
## 4384   4384  28       student   single secondary      no     154     yes   no   unknown  20   may 2008
## 4385   4385  31    management   single secondary      no       0     yes   no   unknown  20   may 2008
## 4386   4386  48    technician   single secondary      no     479      no   no   unknown  20   may 2008
## 4387   4387  38    management divorced  tertiary      no    -980     yes   no   unknown  20   may 2008
## 4388   4388  38    management   single  tertiary      no     690     yes   no   unknown  20   may 2008
## 4389   4389  32    management divorced  tertiary      no    5306     yes   no   unknown  20   may 2008
## 4390   4390  33        admin.  married secondary      no     730     yes   no   unknown  20   may 2008
## 4391   4391  41      services   single secondary      no     397     yes   no   unknown  20   may 2008
## 4392   4392  33        admin.   single secondary      no     434     yes   no   unknown  20   may 2008
## 4393   4393  37    management  married  tertiary      no     897      no   no   unknown  20   may 2008
## 4394   4394  55    technician divorced secondary      no       0     yes   no   unknown  20   may 2008
## 4395   4395  32      services   single secondary      no     228     yes   no   unknown  20   may 2008
## 4396   4396  33    management   single  tertiary      no     201     yes   no   unknown  20   may 2008
## 4397   4397  54    management  married  tertiary      no    2847     yes   no   unknown  20   may 2008
## 4398   4398  39        admin.   single secondary      no    4039     yes   no   unknown  20   may 2008
## 4399   4399  60    technician  married   unknown      no     132     yes   no   unknown  20   may 2008
## 4400   4400  30   blue-collar  married secondary      no       9     yes   no   unknown  20   may 2008
## 4401   4401  34    management   single secondary      no      31     yes   no   unknown  20   may 2008
## 4402   4402  57    management  married  tertiary      no       0     yes  yes   unknown  20   may 2008
## 4403   4403  36   blue-collar  married secondary      no    4438     yes   no   unknown  20   may 2008
## 4404   4404  39        admin.  married secondary      no    6421      no  yes   unknown  20   may 2008
## 4405   4405  38   blue-collar  married secondary      no     171     yes  yes   unknown  20   may 2008
## 4406   4406  37    management divorced  tertiary      no      42     yes  yes   unknown  20   may 2008
## 4407   4407  36    management  married  tertiary      no     806     yes   no   unknown  20   may 2008
## 4408   4408  39   blue-collar  married secondary      no     298     yes   no   unknown  20   may 2008
## 4409   4409  35  entrepreneur  married secondary      no      24     yes   no   unknown  20   may 2008
## 4410   4410  47   blue-collar  married secondary      no     290     yes   no   unknown  20   may 2008
## 4411   4411  37    management  married  tertiary      no     425     yes   no   unknown  20   may 2008
## 4412   4412  39    unemployed  married secondary      no       0     yes   no   unknown  20   may 2008
## 4413   4413  35   blue-collar  married secondary      no    1602     yes  yes   unknown  20   may 2008
## 4414   4414  32    management divorced   primary      no     137     yes   no   unknown  20   may 2008
## 4415   4415  30    management   single  tertiary      no    3110     yes   no   unknown  20   may 2008
## 4416   4416  38   blue-collar   single   primary      no     419     yes   no   unknown  20   may 2008
## 4417   4417  35   blue-collar divorced secondary      no       0     yes   no   unknown  20   may 2008
## 4418   4418  31   blue-collar  married secondary      no     -88     yes   no   unknown  20   may 2008
## 4419   4419  35   blue-collar  married secondary      no     274     yes  yes   unknown  20   may 2008
## 4420   4420  38    management  married  tertiary      no       0     yes   no   unknown  20   may 2008
## 4421   4421  34      services  married secondary      no       0     yes   no   unknown  20   may 2008
## 4422   4422  30    management   single  tertiary      no     162     yes   no   unknown  20   may 2008
## 4423   4423  31      services divorced secondary      no    1222     yes   no   unknown  20   may 2008
## 4424   4424  54      services  married secondary      no    4482     yes   no   unknown  20   may 2008
## 4425   4425  40    technician  married secondary      no    1259      no   no   unknown  20   may 2008
## 4426   4426  35   blue-collar  married secondary      no     499     yes   no   unknown  20   may 2008
## 4427   4427  35    technician   single secondary      no    1861     yes   no   unknown  20   may 2008
## 4428   4428  29      services   single secondary      no     271     yes   no   unknown  20   may 2008
## 4429   4429  33        admin.   single  tertiary      no     622     yes   no   unknown  20   may 2008
## 4430   4430  31       student   single secondary      no     368     yes   no   unknown  20   may 2008
## 4431   4431  51     housemaid  married   primary      no     492     yes   no   unknown  20   may 2008
## 4432   4432  35   blue-collar  married   primary      no     102     yes   no   unknown  20   may 2008
## 4433   4433  38 self-employed  married secondary      no     736     yes   no   unknown  20   may 2008
## 4434   4434  36    unemployed  married secondary      no     733     yes   no   unknown  20   may 2008
## 4435   4435  37    management  married secondary      no    3175     yes   no   unknown  20   may 2008
## 4436   4436  29    technician  married  tertiary      no      43     yes   no   unknown  20   may 2008
## 4437   4437  53      services  married   primary      no     574     yes   no   unknown  20   may 2008
## 4438   4438  34   blue-collar  married secondary      no    4622     yes  yes   unknown  20   may 2008
## 4439   4439  31 self-employed   single  tertiary      no    1820     yes   no   unknown  20   may 2008
## 4440   4440  38        admin. divorced secondary      no    3750     yes   no   unknown  20   may 2008
## 4441   4441  36        admin.  married secondary      no     465     yes   no   unknown  20   may 2008
## 4442   4442  36    management  married  tertiary      no     860     yes   no   unknown  20   may 2008
## 4443   4443  32       student   single   unknown      no    1583     yes   no   unknown  20   may 2008
## 4444   4444  38   blue-collar  married secondary      no       0     yes   no   unknown  20   may 2008
## 4445   4445  36   blue-collar  married secondary      no    7579     yes   no   unknown  20   may 2008
## 4446   4446  35   blue-collar  married secondary      no    4635     yes   no   unknown  20   may 2008
## 4447   4447  31    management  married  tertiary      no     827      no   no   unknown  20   may 2008
## 4448   4448  32   blue-collar  married   primary      no       0     yes   no   unknown  20   may 2008
## 4449   4449  32      services  married secondary      no     364     yes   no   unknown  20   may 2008
## 4450   4450  36      services  married secondary      no     380     yes   no   unknown  20   may 2008
## 4451   4451  32    unemployed  married secondary      no      93     yes   no   unknown  20   may 2008
## 4452   4452  33   blue-collar  married  tertiary      no    6138     yes   no   unknown  20   may 2008
## 4453   4453  30   blue-collar  married secondary      no    1803     yes   no   unknown  20   may 2008
## 4454   4454  39      services  married secondary      no       0     yes   no   unknown  20   may 2008
## 4455   4455  35        admin.  married secondary      no    3187     yes   no   unknown  20   may 2008
## 4456   4456  31   blue-collar  married secondary      no       2     yes   no   unknown  20   may 2008
## 4457   4457  30      services   single secondary      no     695     yes   no   unknown  20   may 2008
## 4458   4458  34      services  married   primary      no    1042     yes   no   unknown  20   may 2008
## 4459   4459  30   blue-collar   single secondary      no    4648     yes   no   unknown  20   may 2008
## 4460   4460  31   blue-collar   single secondary      no    2089     yes   no   unknown  20   may 2008
## 4461   4461  39 self-employed  married  tertiary      no    3059     yes  yes   unknown  20   may 2008
## 4462   4462  36    technician  married secondary      no     412     yes  yes   unknown  20   may 2008
## 4463   4463  32    management   single  tertiary      no     863     yes   no   unknown  20   may 2008
## 4464   4464  33      services  married secondary      no    4434     yes   no   unknown  20   may 2008
## 4465   4465  33      services  married secondary      no    5499     yes   no   unknown  20   may 2008
## 4466   4466  34    technician divorced secondary      no    3997     yes   no   unknown  20   may 2008
## 4467   4467  39     housemaid  married   primary      no    4904     yes   no   unknown  20   may 2008
## 4468   4468  35    management  married  tertiary      no     440     yes   no   unknown  20   may 2008
## 4469   4469  60       retired   single secondary      no     -14     yes   no   unknown  20   may 2008
## 4470   4470  34    technician   single  tertiary      no     759      no   no   unknown  20   may 2008
## 4471   4471  33    technician  married secondary      no     603     yes   no   unknown  20   may 2008
## 4472   4472  59        admin. divorced secondary      no     -41     yes  yes   unknown  20   may 2008
## 4473   4473  31        admin.   single secondary      no      78      no   no   unknown  20   may 2008
## 4474   4474  36    technician  married secondary      no      84     yes   no   unknown  20   may 2008
## 4475   4475  36    technician divorced secondary      no     409     yes   no   unknown  20   may 2008
## 4476   4476  38   blue-collar  married secondary      no     732     yes  yes   unknown  20   may 2008
## 4477   4477  32   blue-collar  married secondary      no     328     yes   no   unknown  20   may 2008
## 4478   4478  32    technician   single secondary      no    1698     yes   no   unknown  20   may 2008
## 4479   4479  39      services  married secondary      no    9374     yes   no   unknown  20   may 2008
## 4480   4480  39       retired  married secondary      no     439      no   no   unknown  20   may 2008
## 4481   4481  33     housemaid  married  tertiary      no    4958     yes   no   unknown  20   may 2008
## 4482   4482  23      services   single secondary      no     210     yes   no   unknown  20   may 2008
## 4483   4483  39  entrepreneur  married  tertiary      no    2644     yes   no   unknown  20   may 2008
## 4484   4484  36   blue-collar  married   unknown      no   17983     yes   no   unknown  20   may 2008
## 4485   4485  38    technician   single secondary      no     614     yes   no   unknown  20   may 2008
## 4486   4486  35        admin.  married secondary      no    2137     yes   no   unknown  20   may 2008
## 4487   4487  27    technician   single  tertiary      no    -291     yes   no   unknown  20   may 2008
## 4488   4488  31        admin.   single secondary      no     160     yes  yes   unknown  20   may 2008
## 4489   4489  58     housemaid  married   primary      no      11     yes   no   unknown  20   may 2008
## 4490   4490  34    technician divorced secondary      no    2036     yes  yes   unknown  20   may 2008
## 4491   4491  31        admin.   single secondary      no     121     yes   no   unknown  20   may 2008
## 4492   4492  36   blue-collar  married   unknown      no    -656     yes   no   unknown  20   may 2008
## 4493   4493  34        admin.  married secondary      no    1689      no   no   unknown  20   may 2008
## 4494   4494  37    technician  married secondary      no     439     yes   no   unknown  20   may 2008
## 4495   4495  37        admin.  married secondary      no    1283     yes   no   unknown  20   may 2008
## 4496   4496  33    technician   single secondary      no    1769     yes   no   unknown  20   may 2008
## 4497   4497  33        admin.  married secondary      no       2     yes   no   unknown  20   may 2008
## 4498   4498  39   blue-collar  married secondary      no       0     yes  yes   unknown  20   may 2008
## 4499   4499  35   blue-collar   single   primary      no      47      no   no   unknown  20   may 2008
## 4500   4500  35   blue-collar  married secondary      no    2054     yes   no   unknown  20   may 2008
## 4501   4501  34      services   single secondary      no    8132     yes   no   unknown  20   may 2008
## 4502   4502  39      services  married secondary      no     453     yes  yes   unknown  20   may 2008
## 4503   4503  37    management   single  tertiary      no     427     yes   no   unknown  20   may 2008
## 4504   4504  42    management  married secondary      no    2416     yes   no   unknown  20   may 2008
## 4505   4505  40   blue-collar  married secondary      no     877     yes   no   unknown  20   may 2008
## 4506   4506  37   blue-collar  married   primary      no     398     yes  yes   unknown  20   may 2008
## 4507   4507  37   blue-collar  married   primary      no    2240     yes   no   unknown  20   may 2008
## 4508   4508  36    technician   single secondary      no     380     yes   no   unknown  20   may 2008
## 4509   4509  35  entrepreneur  married secondary      no    1163     yes   no   unknown  20   may 2008
## 4510   4510  35      services  married secondary      no    4170     yes   no   unknown  20   may 2008
## 4511   4511  37    management  married  tertiary      no    5432     yes  yes   unknown  20   may 2008
## 4512   4512  35    technician divorced secondary     yes     -52     yes   no   unknown  20   may 2008
## 4513   4513  30 self-employed   single secondary      no    4011     yes   no   unknown  20   may 2008
## 4514   4514  37    management   single   unknown      no     715     yes   no   unknown  20   may 2008
## 4515   4515  31        admin.   single secondary      no    2144     yes   no   unknown  20   may 2008
## 4516   4516  56  entrepreneur  married  tertiary      no    8741     yes   no   unknown  20   may 2008
## 4517   4517  37   blue-collar  married secondary      no     362     yes   no   unknown  20   may 2008
## 4518   4518  33   blue-collar  married   primary      no     163     yes   no   unknown  20   may 2008
## 4519   4519  40   blue-collar  married   primary      no    -740     yes   no   unknown  20   may 2008
## 4520   4520  38      services  married secondary      no     434     yes   no   unknown  20   may 2008
## 4521   4521  41      services   single secondary      no    1629     yes   no   unknown  20   may 2008
## 4522   4522  38   blue-collar  married secondary      no    -152      no   no   unknown  20   may 2008
## 4523   4523  36    technician  married secondary      no    3763     yes   no   unknown  20   may 2008
## 4524   4524  31    technician   single secondary      no       1     yes   no   unknown  20   may 2008
## 4525   4525  31    technician  married secondary      no       4      no   no   unknown  20   may 2008
## 4526   4526  52   blue-collar divorced   primary      no       0     yes  yes   unknown  20   may 2008
## 4527   4527  31    management   single  tertiary      no    2007     yes   no   unknown  20   may 2008
## 4528   4528  39   blue-collar  married secondary      no     327     yes   no   unknown  20   may 2008
## 4529   4529  35        admin.  married secondary      no    -130     yes   no   unknown  20   may 2008
## 4530   4530  22      services  married secondary      no      14     yes  yes   unknown  20   may 2008
## 4531   4531  38        admin.  married  tertiary      no    4399     yes   no   unknown  20   may 2008
## 4532   4532  39   blue-collar  married   primary      no     780     yes   no   unknown  20   may 2008
## 4533   4533  34      services   single  tertiary      no     371      no   no   unknown  20   may 2008
## 4534   4534  34   blue-collar  married   primary      no     161     yes  yes   unknown  20   may 2008
## 4535   4535  36   blue-collar divorced secondary      no     221     yes   no   unknown  20   may 2008
## 4536   4536  32   blue-collar   single secondary      no     706     yes   no   unknown  20   may 2008
## 4537   4537  33    management   single   primary      no    4897     yes   no   unknown  20   may 2008
## 4538   4538  33      services  married secondary      no       7     yes   no   unknown  20   may 2008
## 4539   4539  36        admin.  married secondary      no    2030     yes   no   unknown  20   may 2008
## 4540   4540  32   blue-collar  married secondary      no     489     yes   no   unknown  20   may 2008
## 4541   4541  42   blue-collar  married   primary      no    1059     yes   no   unknown  20   may 2008
## 4542   4542  43    management  married  tertiary      no      -8     yes   no   unknown  20   may 2008
## 4543   4543  35 self-employed   single secondary      no     271     yes   no   unknown  20   may 2008
## 4544   4544  37     housemaid   single secondary      no    2042     yes   no   unknown  20   may 2008
## 4545   4545  33   blue-collar  married secondary      no     -53     yes   no   unknown  20   may 2008
## 4546   4546  26       student   single secondary      no     268     yes   no   unknown  20   may 2008
## 4547   4547  37    technician   single  tertiary      no    5122     yes   no   unknown  20   may 2008
## 4548   4548  33      services  married secondary      no     403     yes   no   unknown  20   may 2008
## 4549   4549  40        admin.  married  tertiary      no       0     yes   no   unknown  20   may 2008
## 4550   4550  36    technician divorced secondary      no     566     yes   no   unknown  20   may 2008
## 4551   4551  35   blue-collar  married   primary      no     356     yes  yes   unknown  20   may 2008
## 4552   4552  36   blue-collar  married   unknown      no     722     yes   no   unknown  20   may 2008
## 4553   4553  39        admin. divorced secondary      no    -607     yes   no   unknown  20   may 2008
## 4554   4554  60    management  married  tertiary      no     328     yes   no   unknown  20   may 2008
## 4555   4555  34        admin.   single secondary      no     126     yes   no   unknown  20   may 2008
## 4556   4556  32   blue-collar  married   primary      no     206     yes   no   unknown  20   may 2008
## 4557   4557  33    management   single  tertiary      no     136     yes  yes   unknown  20   may 2008
## 4558   4558  59   blue-collar  married   primary      no      14     yes  yes   unknown  20   may 2008
## 4559   4559  35    management   single secondary      no    5260     yes   no   unknown  20   may 2008
## 4560   4560  34        admin.   single  tertiary      no     458     yes   no   unknown  20   may 2008
## 4561   4561  42    management  married  tertiary      no       0      no   no   unknown  20   may 2008
## 4562   4562  38  entrepreneur  married   primary      no     666     yes   no   unknown  20   may 2008
## 4563   4563  33      services  married   unknown      no      89     yes   no   unknown  20   may 2008
## 4564   4564  32   blue-collar   single   primary      no    1660      no   no   unknown  20   may 2008
## 4565   4565  30   blue-collar  married secondary      no     673     yes   no   unknown  20   may 2008
## 4566   4566  34    management   single  tertiary      no     673     yes  yes   unknown  20   may 2008
## 4567   4567  59       retired  married secondary      no    -313     yes   no   unknown  20   may 2008
## 4568   4568  32        admin.  married secondary      no       0     yes   no   unknown  20   may 2008
## 4569   4569  54     housemaid  married secondary      no     167     yes   no   unknown  20   may 2008
## 4570   4570  48    management divorced   primary      no     432     yes   no   unknown  20   may 2008
## 4571   4571  36   blue-collar  married   primary      no    8135     yes   no   unknown  20   may 2008
## 4572   4572  29      services   single secondary      no       0     yes   no   unknown  20   may 2008
## 4573   4573  39   blue-collar   single secondary      no    4286     yes   no   unknown  20   may 2008
## 4574   4574  54      services divorced   unknown      no    2177      no   no   unknown  20   may 2008
## 4575   4575  36        admin.   single secondary      no       0      no   no   unknown  20   may 2008
## 4576   4576  33    technician  married secondary      no     105     yes  yes   unknown  20   may 2008
## 4577   4577  32    management   single  tertiary      no    1271     yes   no   unknown  20   may 2008
## 4578   4578  41      services divorced secondary      no      83      no   no   unknown  20   may 2008
## 4579   4579  34   blue-collar   single   primary      no     709     yes   no   unknown  20   may 2008
## 4580   4580  34      services  married secondary      no     -93     yes  yes   unknown  20   may 2008
## 4581   4581  53     housemaid  married secondary      no     736     yes   no   unknown  20   may 2008
## 4582   4582  38      services  married secondary     yes    -242     yes  yes   unknown  20   may 2008
## 4583   4583  33   blue-collar  married secondary      no    3259     yes   no   unknown  20   may 2008
## 4584   4584  32    technician  married secondary      no   11697     yes   no   unknown  20   may 2008
## 4585   4585  33      services  married secondary      no     210     yes  yes   unknown  20   may 2008
## 4586   4586  35   blue-collar  married secondary      no    2688     yes   no   unknown  20   may 2008
## 4587   4587  34    management  married  tertiary      no       0     yes   no   unknown  20   may 2008
## 4588   4588  37  entrepreneur  married secondary      no    5064     yes   no   unknown  20   may 2008
## 4589   4589  38    unemployed  married secondary      no     205     yes   no   unknown  20   may 2008
## 4590   4590  39     housemaid  married  tertiary      no      75     yes   no   unknown  20   may 2008
## 4591   4591  43   blue-collar  married   primary      no       0     yes   no   unknown  20   may 2008
## 4592   4592  39        admin.  married secondary      no    2019     yes   no   unknown  20   may 2008
## 4593   4593  38   blue-collar  married   primary      no     178     yes   no   unknown  20   may 2008
## 4594   4594  40      services  married   primary      no    3559     yes   no   unknown  20   may 2008
## 4595   4595  38 self-employed  married secondary      no     290     yes   no   unknown  20   may 2008
## 4596   4596  32        admin. divorced secondary      no     138     yes  yes   unknown  20   may 2008
## 4597   4597  31   blue-collar   single secondary      no    5607      no   no   unknown  20   may 2008
## 4598   4598  32   blue-collar  married   primary      no    8291      no   no   unknown  20   may 2008
## 4599   4599  37   blue-collar   single   primary      no    6969     yes   no   unknown  20   may 2008
## 4600   4600  30    management   single  tertiary      no      18      no   no   unknown  20   may 2008
## 4601   4601  46  entrepreneur  married secondary      no     583     yes   no   unknown  20   may 2008
## 4602   4602  36     housemaid   single secondary      no    7171     yes   no   unknown  20   may 2008
## 4603   4603  34   blue-collar  married   primary      no     500     yes   no   unknown  20   may 2008
## 4604   4604  32   blue-collar  married secondary      no     113     yes  yes   unknown  20   may 2008
## 4605   4605  34      services divorced secondary      no       0     yes  yes   unknown  20   may 2008
## 4606   4606  33   blue-collar  married   primary      no    3512     yes   no   unknown  20   may 2008
## 4607   4607  37  entrepreneur  married  tertiary      no    4798     yes   no   unknown  20   may 2008
## 4608   4608  34    technician   single secondary      no      85     yes   no   unknown  20   may 2008
## 4609   4609  37   blue-collar  married   primary      no     660     yes  yes   unknown  20   may 2008
## 4610   4610  31      services  married  tertiary      no     585     yes  yes   unknown  20   may 2008
## 4611   4611  47  entrepreneur  married secondary      no     136     yes   no   unknown  20   may 2008
## 4612   4612  36    management   single secondary      no     360     yes   no   unknown  20   may 2008
## 4613   4613  31    unemployed  married secondary      no     296     yes   no   unknown  20   may 2008
## 4614   4614  33   blue-collar  married secondary      no       0     yes  yes   unknown  20   may 2008
## 4615   4615  33   blue-collar  married secondary      no      10     yes  yes   unknown  20   may 2008
## 4616   4616  39   blue-collar  married   primary      no     451     yes   no   unknown  20   may 2008
## 4617   4617  37   blue-collar divorced secondary      no     614     yes   no   unknown  20   may 2008
## 4618   4618  34    technician   single secondary      no     692     yes   no   unknown  20   may 2008
## 4619   4619  33    management  married  tertiary      no     148      no   no   unknown  20   may 2008
## 4620   4620  31   blue-collar   single   primary      no    5058     yes   no   unknown  20   may 2008
## 4621   4621  33        admin.  married secondary      no    1467     yes   no   unknown  20   may 2008
## 4622   4622  30    management  married  tertiary      no     859     yes   no   unknown  20   may 2008
## 4623   4623  34      services  married secondary      no    -508     yes   no   unknown  20   may 2008
## 4624   4624  31       student   single  tertiary      no     410     yes   no   unknown  20   may 2008
## 4625   4625  36  entrepreneur  married secondary      no     134      no   no   unknown  20   may 2008
## 4626   4626  37    management   single  tertiary      no   23867      no   no   unknown  20   may 2008
## 4627   4627  31      services   single secondary      no    2038     yes   no   unknown  20   may 2008
## 4628   4628  39        admin.  married secondary      no    -362     yes   no   unknown  20   may 2008
## 4629   4629  34    management  married  tertiary      no     967     yes   no   unknown  20   may 2008
## 4630   4630  43    management  married  tertiary      no    1825     yes   no   unknown  20   may 2008
## 4631   4631  43   blue-collar  married   primary     yes    -635     yes   no   unknown  20   may 2008
## 4632   4632  34   blue-collar  married secondary      no    1298     yes   no   unknown  20   may 2008
## 4633   4633  36   blue-collar  married secondary      no    1797     yes  yes   unknown  20   may 2008
## 4634   4634  55        admin.  married   unknown      no    1848     yes   no   unknown  20   may 2008
## 4635   4635  31        admin.   single secondary      no     431     yes  yes   unknown  20   may 2008
## 4636   4636  32   blue-collar  married secondary      no    4996     yes   no   unknown  20   may 2008
## 4637   4637  31   blue-collar  married secondary      no     213     yes   no   unknown  20   may 2008
## 4638   4638  31   blue-collar  married   primary      no      26     yes   no   unknown  20   may 2008
## 4639   4639  33    management   single secondary      no       0      no   no   unknown  20   may 2008
## 4640   4640  32        admin.  married   primary      no    1351     yes   no   unknown  20   may 2008
## 4641   4641  44    technician divorced secondary      no     982     yes   no   unknown  20   may 2008
## 4642   4642  33      services  married secondary      no    4963     yes   no   unknown  20   may 2008
## 4643   4643  39      services  married secondary      no    1438     yes   no   unknown  20   may 2008
## 4644   4644  39   blue-collar  married   primary      no    1411     yes   no   unknown  20   may 2008
## 4645   4645  33      services   single secondary      no       0     yes   no   unknown  20   may 2008
## 4646   4646  40   blue-collar  married   unknown      no     486     yes   no   unknown  20   may 2008
## 4647   4647  34    technician   single secondary      no    1183     yes   no   unknown  20   may 2008
## 4648   4648  39    management  married  tertiary      no     351     yes   no   unknown  20   may 2008
## 4649   4649  32   blue-collar  married secondary      no    2366     yes   no   unknown  20   may 2008
## 4650   4650  34   blue-collar  married secondary      no    2700     yes   no   unknown  20   may 2008
## 4651   4651  59   blue-collar  married secondary      no       0     yes   no   unknown  20   may 2008
## 4652   4652  39   blue-collar  married   primary      no     622     yes   no   unknown  20   may 2008
## 4653   4653  34      services  married secondary     yes     421     yes   no   unknown  20   may 2008
## 4654   4654  36      services   single secondary      no     774     yes   no   unknown  20   may 2008
## 4655   4655  35   blue-collar  married secondary      no      67      no   no   unknown  20   may 2008
## 4656   4656  39    technician  married secondary      no    7313     yes   no   unknown  20   may 2008
## 4657   4657  57     housemaid divorced   primary      no     231     yes   no   unknown  20   may 2008
## 4658   4658  46    management  married  tertiary      no     477     yes   no   unknown  20   may 2008
## 4659   4659  58   blue-collar  married   primary      no      99     yes   no   unknown  20   may 2008
## 4660   4660  32    technician  married secondary      no     908     yes   no   unknown  20   may 2008
## 4661   4661  34        admin.   single secondary      no    1581     yes  yes   unknown  20   may 2008
## 4662   4662  35    technician   single  tertiary      no    2012     yes   no   unknown  20   may 2008
## 4663   4663  36    technician   single  tertiary      no     162     yes   no   unknown  20   may 2008
## 4664   4664  40    management  married  tertiary      no     917     yes   no   unknown  20   may 2008
## 4665   4665  44      services  married secondary      no    1422     yes   no   unknown  20   may 2008
## 4666   4666  31   blue-collar  married secondary      no    1787     yes   no   unknown  20   may 2008
## 4667   4667  55 self-employed  married secondary      no    -196     yes   no   unknown  20   may 2008
## 4668   4668  35    technician  married secondary      no    1387     yes   no   unknown  20   may 2008
## 4669   4669  31    unemployed  married   primary      no     -63     yes   no   unknown  20   may 2008
## 4670   4670  35    management   single  tertiary      no    1423     yes   no   unknown  20   may 2008
## 4671   4671  36        admin.  married  tertiary      no    3127     yes   no   unknown  20   may 2008
## 4672   4672  36    technician   single secondary      no    5436     yes   no   unknown  20   may 2008
## 4673   4673  30    management   single  tertiary      no    1724     yes   no   unknown  20   may 2008
## 4674   4674  31   blue-collar  married secondary      no       0     yes   no   unknown  20   may 2008
## 4675   4675  41      services  married secondary      no     804     yes   no   unknown  20   may 2008
## 4676   4676  36   blue-collar  married   primary      no     408     yes  yes   unknown  20   may 2008
## 4677   4677  59  entrepreneur  married  tertiary      no     705     yes   no   unknown  20   may 2008
## 4678   4678  36    management   single  tertiary      no    1373     yes   no   unknown  20   may 2008
## 4679   4679  32    technician  married   unknown      no     196     yes   no   unknown  20   may 2008
## 4680   4680  39   blue-collar  married secondary      no       0     yes   no   unknown  20   may 2008
## 4681   4681  38    technician divorced secondary      no     273     yes   no   unknown  20   may 2008
## 4682   4682  40 self-employed  married secondary      no     311     yes   no   unknown  20   may 2008
## 4683   4683  39    technician   single secondary      no    1022     yes   no   unknown  20   may 2008
## 4684   4684  30      services   single secondary      no     862     yes  yes   unknown  20   may 2008
## 4685   4685  38      services  married secondary      no     173     yes   no   unknown  20   may 2008
## 4686   4686  32      services  married secondary      no     204     yes  yes   unknown  20   may 2008
## 4687   4687  37   blue-collar  married secondary      no      32     yes   no   unknown  20   may 2008
## 4688   4688  31    management  married  tertiary      no    4761     yes   no   unknown  20   may 2008
## 4689   4689  44   blue-collar  married secondary      no    1081     yes   no   unknown  20   may 2008
## 4690   4690  45   blue-collar  married   primary      no    4170     yes  yes   unknown  20   may 2008
## 4691   4691  36   blue-collar   single secondary      no    3111     yes   no   unknown  20   may 2008
## 4692   4692  27   blue-collar   single   unknown      no      89     yes   no   unknown  20   may 2008
## 4693   4693  27   blue-collar   single secondary      no     317     yes   no   unknown  20   may 2008
## 4694   4694  48   blue-collar  married secondary      no    5058      no   no   unknown  20   may 2008
## 4695   4695  41   blue-collar  married secondary      no    2852     yes   no   unknown  20   may 2008
## 4696   4696  36   blue-collar   single secondary      no    2390     yes   no   unknown  20   may 2008
## 4697   4697  32    management   single  tertiary      no    1131     yes   no   unknown  20   may 2008
## 4698   4698  31        admin. divorced secondary      no    1352     yes   no   unknown  20   may 2008
## 4699   4699  43       retired  married secondary      no     520     yes   no   unknown  20   may 2008
## 4700   4700  33    management  married  tertiary      no     876      no   no   unknown  20   may 2008
## 4701   4701  31   blue-collar  married   primary      no     855     yes  yes   unknown  20   may 2008
## 4702   4702  35    management   single secondary     yes    -202     yes   no   unknown  20   may 2008
## 4703   4703  27        admin.   single secondary      no    -215     yes   no   unknown  20   may 2008
## 4704   4704  32      services divorced  tertiary      no     376     yes   no   unknown  20   may 2008
## 4705   4705  58   blue-collar  married   primary      no      23     yes   no   unknown  20   may 2008
## 4706   4706  40   blue-collar  married   unknown      no     222     yes   no   unknown  20   may 2008
## 4707   4707  36   blue-collar  married secondary      no     362     yes   no   unknown  20   may 2008
## 4708   4708  39    technician  married  tertiary      no     602     yes   no   unknown  20   may 2008
## 4709   4709  37   blue-collar  married secondary      no     426     yes   no   unknown  20   may 2008
## 4710   4710  30   blue-collar  married secondary      no    5143     yes  yes   unknown  20   may 2008
## 4711   4711  32   blue-collar  married   primary      no      80     yes   no   unknown  20   may 2008
## 4712   4712  52      services  married secondary      no       0     yes   no   unknown  20   may 2008
## 4713   4713  32   blue-collar  married   primary      no    7406     yes   no   unknown  20   may 2008
## 4714   4714  33    unemployed divorced secondary      no    1005     yes   no   unknown  20   may 2008
## 4715   4715  39   blue-collar divorced secondary      no     226     yes   no   unknown  20   may 2008
## 4716   4716  39    management   single secondary      no     247     yes   no   unknown  20   may 2008
## 4717   4717  34    management   single  tertiary      no    1040     yes   no   unknown  20   may 2008
## 4718   4718  29      services  married secondary      no      68      no   no   unknown  20   may 2008
## 4719   4719  36      services  married secondary      no     183     yes   no   unknown  20   may 2008
## 4720   4720  35   blue-collar  married   unknown      no    4822     yes   no   unknown  20   may 2008
## 4721   4721  49    technician   single secondary      no       0     yes   no   unknown  20   may 2008
## 4722   4722  31   blue-collar   single   primary      no    1097     yes   no   unknown  20   may 2008
## 4723   4723  39      services  married secondary      no    5731     yes   no   unknown  20   may 2008
## 4724   4724  32    technician  married secondary      no    3067     yes   no   unknown  20   may 2008
## 4725   4725  35   blue-collar   single secondary      no     275     yes   no   unknown  20   may 2008
## 4726   4726  38   blue-collar  married secondary      no     526     yes   no   unknown  20   may 2008
## 4727   4727  34   blue-collar  married secondary      no    1831     yes   no   unknown  20   may 2008
## 4728   4728  35   blue-collar  married secondary      no     514     yes   no   unknown  20   may 2008
## 4729   4729  34        admin.  married secondary      no      50     yes   no   unknown  20   may 2008
## 4730   4730  34    technician  married  tertiary      no       0     yes   no   unknown  20   may 2008
## 4731   4731  27    technician   single secondary      no       8     yes   no   unknown  20   may 2008
## 4732   4732  30      services   single secondary      no     432     yes   no   unknown  20   may 2008
## 4733   4733  32   blue-collar  married secondary      no    2561     yes   no   unknown  20   may 2008
## 4734   4734  30    technician   single secondary      no     659     yes   no   unknown  20   may 2008
## 4735   4735  38   blue-collar  married   primary      no       0     yes  yes   unknown  20   may 2008
## 4736   4736  31   blue-collar  married secondary      no     897     yes   no   unknown  20   may 2008
## 4737   4737  23       student   single secondary      no    -116     yes   no   unknown  20   may 2008
## 4738   4738  30    unemployed  married secondary      no     142     yes   no   unknown  20   may 2008
## 4739   4739  56      services  married secondary      no     530     yes   no   unknown  20   may 2008
## 4740   4740  32   blue-collar  married secondary      no    3514     yes   no   unknown  20   may 2008
## 4741   4741  35        admin.  married secondary      no     190     yes   no   unknown  20   may 2008
## 4742   4742  40   blue-collar  married   primary      no     236     yes   no   unknown  20   may 2008
## 4743   4743  57    management  married  tertiary      no    -871      no   no   unknown  20   may 2008
## 4744   4744  58  entrepreneur  married secondary      no    2429      no  yes   unknown  20   may 2008
## 4745   4745  32    technician  married  tertiary      no     514     yes   no   unknown  20   may 2008
## 4746   4746  38    unemployed  married secondary      no     565     yes   no   unknown  20   may 2008
## 4747   4747  50   blue-collar  married   primary      no    2610     yes  yes   unknown  20   may 2008
## 4748   4748  30   blue-collar   single secondary      no     178     yes   no   unknown  20   may 2008
## 4749   4749  34   blue-collar  married   unknown      no    1117     yes   no   unknown  20   may 2008
## 4750   4750  30    technician divorced secondary      no       4     yes   no   unknown  20   may 2008
## 4751   4751  38       unknown  married   unknown      no     124     yes   no   unknown  20   may 2008
## 4752   4752  55   blue-collar  married   primary      no    2144     yes   no   unknown  20   may 2008
## 4753   4753  31      services   single  tertiary      no    1025      no   no   unknown  20   may 2008
## 4754   4754  41   blue-collar  married   primary      no    1250     yes   no   unknown  20   may 2008
## 4755   4755  38        admin.  married   unknown      no      28      no   no   unknown  20   may 2008
## 4756   4756  49    management  married secondary      no     543     yes   no   unknown  20   may 2008
## 4757   4757  26   blue-collar   single secondary      no     972     yes   no   unknown  20   may 2008
## 4758   4758  60   blue-collar  married   primary      no     674     yes   no   unknown  20   may 2008
## 4759   4759  57   blue-collar  married secondary      no     258     yes   no   unknown  20   may 2008
## 4760   4760  37   blue-collar   single   unknown      no    3044     yes   no   unknown  20   may 2008
## 4761   4761  39   blue-collar  married   primary      no    -197     yes   no   unknown  20   may 2008
## 4762   4762  39   blue-collar  married   unknown      no    1096      no   no   unknown  20   may 2008
## 4763   4763  57      services divorced secondary      no     739     yes   no   unknown  20   may 2008
## 4764   4764  35   blue-collar  married secondary      no     274     yes   no   unknown  20   may 2008
## 4765   4765  30   blue-collar  married secondary      no    1445     yes   no   unknown  20   may 2008
## 4766   4766  31   blue-collar  married secondary      no    3311     yes   no   unknown  20   may 2008
## 4767   4767  32   blue-collar  married secondary      no     157     yes   no   unknown  20   may 2008
## 4768   4768  30      services   single   unknown      no     347     yes   no   unknown  21   may 2008
## 4769   4769  32    management   single  tertiary      no    -345     yes   no   unknown  21   may 2008
## 4770   4770  36    technician  married secondary      no    8119      no   no   unknown  21   may 2008
## 4771   4771  34   blue-collar  married secondary      no     120     yes   no   unknown  21   may 2008
## 4772   4772  39   blue-collar  married   primary      no       5     yes   no   unknown  21   may 2008
## 4773   4773  42    management  married  tertiary      no    2309     yes   no   unknown  21   may 2008
## 4774   4774  33        admin.   single secondary      no     892     yes   no   unknown  21   may 2008
## 4775   4775  32    technician  married secondary      no     641     yes   no   unknown  21   may 2008
## 4776   4776  35   blue-collar  married   primary      no    2730     yes   no   unknown  21   may 2008
## 4777   4777  38   blue-collar  married secondary      no    1663     yes   no   unknown  21   may 2008
## 4778   4778  39   blue-collar  married   primary      no    1966     yes   no   unknown  21   may 2008
## 4779   4779  54       retired divorced  tertiary      no    6102     yes  yes   unknown  21   may 2008
## 4780   4780  38    technician  married  tertiary      no    1092     yes   no   unknown  21   may 2008
## 4781   4781  33      services  married  tertiary      no    1349     yes   no   unknown  21   may 2008
## 4782   4782  34    management   single  tertiary      no    2015      no   no   unknown  21   may 2008
## 4783   4783  32        admin.   single secondary      no    2146     yes   no   unknown  21   may 2008
## 4784   4784  32    management  married  tertiary      no    2976     yes   no   unknown  21   may 2008
## 4785   4785  37        admin. divorced secondary      no    3834     yes   no   unknown  21   may 2008
## 4786   4786  36      services  married secondary      no     393     yes  yes   unknown  21   may 2008
## 4787   4787  32   blue-collar  married   primary      no    -457     yes  yes   unknown  21   may 2008
## 4788   4788  34   blue-collar divorced secondary      no       0      no  yes   unknown  21   may 2008
## 4789   4789  34    management  married  tertiary      no     363      no   no   unknown  21   may 2008
## 4790   4790  39    management   single  tertiary      no    4025     yes  yes   unknown  21   may 2008
## 4791   4791  42   blue-collar  married   primary      no     714     yes   no   unknown  21   may 2008
## 4792   4792  33    unemployed  married secondary      no     438     yes  yes   unknown  21   may 2008
## 4793   4793  40    management   single   primary      no     858     yes   no   unknown  21   may 2008
## 4794   4794  35   blue-collar  married secondary      no     592     yes   no   unknown  21   may 2008
## 4795   4795  38      services  married secondary      no    -224     yes  yes   unknown  21   may 2008
## 4796   4796  39    management  married  tertiary      no     151     yes   no   unknown  21   may 2008
## 4797   4797  31      services  married secondary      no     289     yes   no   unknown  21   may 2008
## 4798   4798  38    technician  married secondary      no     821     yes  yes   unknown  21   may 2008
## 4799   4799  58    technician  married secondary      no    8153     yes   no   unknown  21   may 2008
## 4800   4800  33      services  married secondary      no      57     yes  yes   unknown  21   may 2008
## 4801   4801  34   blue-collar   single secondary      no     558     yes   no   unknown  21   may 2008
## 4802   4802  34      services   single secondary      no    1701     yes   no   unknown  21   may 2008
## 4803   4803  37        admin.   single  tertiary      no    -898     yes   no   unknown  21   may 2008
## 4804   4804  38        admin.  married secondary      no    1073     yes   no   unknown  21   may 2008
## 4805   4805  34    management divorced  tertiary      no    5754     yes   no   unknown  21   may 2008
## 4806   4806  34   blue-collar  married   primary      no    -167     yes   no   unknown  21   may 2008
## 4807   4807  39   blue-collar  married   primary      no    4146     yes  yes   unknown  21   may 2008
## 4808   4808  35  entrepreneur   single  tertiary      no     -15     yes   no   unknown  21   may 2008
## 4809   4809  36        admin.   single  tertiary      no    3954     yes   no   unknown  21   may 2008
## 4810   4810  31    management  married secondary      no    8629     yes   no   unknown  21   may 2008
## 4811   4811  30    technician  married secondary      no    1168     yes  yes   unknown  21   may 2008
## 4812   4812  35        admin.  married secondary      no     498     yes   no   unknown  21   may 2008
## 4813   4813  35    technician divorced secondary      no       0      no   no   unknown  21   may 2008
## 4814   4814  31   blue-collar   single   primary      no     216     yes   no   unknown  21   may 2008
## 4815   4815  38    management   single  tertiary      no    1746     yes   no   unknown  21   may 2008
## 4816   4816  36    technician   single secondary      no    1053     yes   no   unknown  21   may 2008
## 4817   4817  36       student   single  tertiary      no     687     yes   no   unknown  21   may 2008
## 4818   4818  33   blue-collar   single secondary      no    2764     yes   no   unknown  21   may 2008
## 4819   4819  34   blue-collar  married secondary      no    1207     yes   no   unknown  21   may 2008
## 4820   4820  32    management  married  tertiary      no       0     yes   no   unknown  21   may 2008
## 4821   4821  39   blue-collar divorced   unknown      no     528     yes   no   unknown  21   may 2008
## 4822   4822  33    management  married  tertiary      no    3090     yes   no   unknown  21   may 2008
## 4823   4823  38    technician divorced  tertiary     yes    -530     yes   no   unknown  21   may 2008
## 4824   4824  41    management  married  tertiary      no     666     yes   no   unknown  21   may 2008
## 4825   4825  38    technician  married secondary      no       0     yes   no   unknown  21   may 2008
## 4826   4826  35   blue-collar   single secondary      no     470     yes   no   unknown  21   may 2008
## 4827   4827  39    technician  married secondary      no     597     yes   no   unknown  21   may 2008
## 4828   4828  40   blue-collar  married   primary      no    1136     yes   no   unknown  21   may 2008
## 4829   4829  38   blue-collar  married secondary      no     620     yes  yes   unknown  21   may 2008
## 4830   4830  33   blue-collar   single secondary      no      17     yes   no   unknown  21   may 2008
## 4831   4831  34      services  married secondary      no      12      no   no   unknown  21   may 2008
## 4832   4832  28  entrepreneur   single  tertiary      no     135     yes   no   unknown  21   may 2008
## 4833   4833  36      services  married secondary      no    5024      no   no   unknown  21   may 2008
## 4834   4834  34    technician   single secondary      no    1161     yes   no   unknown  21   may 2008
## 4835   4835  39    technician  married secondary      no    3528     yes   no   unknown  21   may 2008
## 4836   4836  32    technician  married secondary      no     791     yes   no   unknown  21   may 2008
## 4837   4837  38    management  married   unknown      no     546     yes   no   unknown  21   may 2008
## 4838   4838  39   blue-collar  married secondary      no     804     yes   no   unknown  21   may 2008
## 4839   4839  30    technician   single secondary      no     908     yes   no   unknown  21   may 2008
## 4840   4840  31   blue-collar   single secondary      no    6982     yes   no   unknown  21   may 2008
## 4841   4841  37    technician divorced secondary      no    1176      no  yes   unknown  21   may 2008
## 4842   4842  36        admin.  married secondary      no       0      no   no   unknown  21   may 2008
## 4843   4843  34   blue-collar  married secondary      no     528     yes   no   unknown  21   may 2008
## 4844   4844  37        admin.  married   unknown      no     734     yes   no   unknown  21   may 2008
## 4845   4845  31    technician   single secondary      no     109     yes   no   unknown  21   may 2008
## 4846   4846  48 self-employed  married secondary      no    4746     yes   no   unknown  21   may 2008
## 4847   4847  31      services  married secondary      no   11512     yes   no   unknown  21   may 2008
## 4848   4848  34      services  married secondary      no       0     yes   no   unknown  21   may 2008
## 4849   4849  36      services  married secondary      no     115      no   no   unknown  21   may 2008
## 4850   4850  36    management   single  tertiary      no     808      no   no   unknown  21   may 2008
## 4851   4851  35    management   single  tertiary      no    -289     yes   no   unknown  21   may 2008
## 4852   4852  35 self-employed  married  tertiary      no   35368     yes   no   unknown  21   may 2008
## 4853   4853  33      services   single secondary      no     189      no   no   unknown  21   may 2008
## 4854   4854  26   blue-collar  married   primary      no       0     yes   no   unknown  21   may 2008
## 4855   4855  37  entrepreneur  married  tertiary      no    1110     yes   no   unknown  21   may 2008
## 4856   4856  32    technician  married   unknown      no     102     yes   no   unknown  21   may 2008
## 4857   4857  33    management  married secondary      no      56     yes   no   unknown  21   may 2008
## 4858   4858  34   blue-collar  married secondary      no     405     yes   no   unknown  21   may 2008
## 4859   4859  36    management  married secondary      no     873     yes   no   unknown  21   may 2008
## 4860   4860  36    technician   single secondary      no     656      no   no   unknown  21   may 2008
## 4861   4861  41    technician  married secondary      no    2490     yes   no   unknown  21   may 2008
## 4862   4862  33        admin.   single secondary      no    1437     yes   no   unknown  21   may 2008
## 4863   4863  35    management   single  tertiary      no    6659     yes   no   unknown  21   may 2008
## 4864   4864  30    technician  married  tertiary      no    1126     yes   no   unknown  21   may 2008
## 4865   4865  34   blue-collar   single secondary      no    3773     yes   no   unknown  21   may 2008
## 4866   4866  34 self-employed   single  tertiary      no    1129     yes   no   unknown  21   may 2008
## 4867   4867  36    management  married  tertiary      no     849     yes  yes   unknown  21   may 2008
## 4868   4868  30      services  married secondary      no     675     yes   no   unknown  21   may 2008
## 4869   4869  36        admin.   single secondary      no      98     yes   no   unknown  21   may 2008
## 4870   4870  31   blue-collar  married secondary      no    1914     yes   no   unknown  21   may 2008
## 4871   4871  34      services  married secondary      no    1270     yes   no   unknown  21   may 2008
## 4872   4872  30  entrepreneur  married   primary      no     -98     yes   no   unknown  21   may 2008
## 4873   4873  33   blue-collar  married   primary      no     256     yes   no   unknown  21   may 2008
## 4874   4874  31   blue-collar  married secondary      no     435     yes   no   unknown  21   may 2008
## 4875   4875  37    unemployed  married   primary      no    7005     yes   no   unknown  21   may 2008
## 4876   4876  38      services   single   primary      no     471     yes   no   unknown  21   may 2008
## 4877   4877  33   blue-collar  married secondary      no     467     yes   no   unknown  21   may 2008
## 4878   4878  32   blue-collar  married   primary      no     323     yes   no   unknown  21   may 2008
## 4879   4879  34    management   single  tertiary      no       0     yes   no   unknown  21   may 2008
## 4880   4880  31    management  married  tertiary      no    1343     yes  yes   unknown  21   may 2008
## 4881   4881  51   blue-collar divorced secondary      no      44      no   no   unknown  21   may 2008
## 4882   4882  30   blue-collar  married   primary      no     453     yes   no   unknown  21   may 2008
## 4883   4883  35  entrepreneur  married secondary      no     350     yes   no   unknown  21   may 2008
## 4884   4884  32    technician  married secondary      no    2693     yes   no   unknown  21   may 2008
## 4885   4885  31   blue-collar  married secondary      no    1243     yes   no   unknown  21   may 2008
## 4886   4886  34    technician  married secondary      no     883     yes   no   unknown  21   may 2008
## 4887   4887  33   blue-collar   single   primary      no     599     yes   no   unknown  21   may 2008
## 4888   4888  31   blue-collar  married secondary      no    3176     yes   no   unknown  21   may 2008
## 4889   4889  33    technician   single secondary      no      49      no   no   unknown  21   may 2008
## 4890   4890  36   blue-collar divorced   primary      no    3202     yes   no   unknown  21   may 2008
## 4891   4891  33    technician   single secondary      no    2660     yes   no   unknown  21   may 2008
## 4892   4892  59       retired  married   primary      no      41     yes  yes   unknown  21   may 2008
## 4893   4893  35   blue-collar  married secondary      no    -557     yes  yes   unknown  21   may 2008
## 4894   4894  33    management  married  tertiary      no     741      no   no   unknown  21   may 2008
## 4895   4895  32    technician   single secondary      no     930     yes   no   unknown  21   may 2008
## 4896   4896  23   blue-collar   single secondary      no       9     yes   no   unknown  21   may 2008
## 4897   4897  33   blue-collar  married secondary      no    1624     yes  yes   unknown  21   may 2008
## 4898   4898  30   blue-collar   single secondary     yes     239     yes   no   unknown  21   may 2008
## 4899   4899  31        admin.   single secondary      no     626     yes   no   unknown  21   may 2008
## 4900   4900  25      services   single secondary      no    -268     yes   no   unknown  21   may 2008
## 4901   4901  37    technician   single  tertiary      no     178     yes   no   unknown  21   may 2008
## 4902   4902  34        admin.  married secondary      no    1671      no   no   unknown  21   may 2008
## 4903   4903  29   blue-collar divorced secondary      no    -300      no   no   unknown  21   may 2008
## 4904   4904  35    technician   single  tertiary      no    1362     yes   no   unknown  21   may 2008
## 4905   4905  31    technician divorced  tertiary      no    2287     yes   no   unknown  21   may 2008
## 4906   4906  33   blue-collar  married   primary      no     141     yes   no   unknown  21   may 2008
## 4907   4907  31    technician  married  tertiary      no    4315     yes   no   unknown  21   may 2008
## 4908   4908  28      services   single   unknown      no     -70     yes  yes   unknown  21   may 2008
## 4909   4909  33    technician  married secondary      no    1630     yes   no   unknown  21   may 2008
## 4910   4910  35    technician  married secondary      no     569     yes   no   unknown  21   may 2008
## 4911   4911  34    management   single  tertiary      no       0     yes   no   unknown  21   may 2008
## 4912   4912  30   blue-collar   single   primary      no     546     yes   no   unknown  21   may 2008
## 4913   4913  32    technician   single secondary      no     287     yes   no   unknown  21   may 2008
## 4914   4914  37      services  married secondary     yes    -954     yes   no   unknown  21   may 2008
## 4915   4915  35  entrepreneur  married  tertiary      no     280     yes   no   unknown  21   may 2008
## 4916   4916  57       retired  married secondary      no    1408      no   no   unknown  21   may 2008
## 4917   4917  37    technician   single secondary      no    1211     yes   no   unknown  21   may 2008
## 4918   4918  27   blue-collar  married secondary      no    1600     yes   no   unknown  21   may 2008
## 4919   4919  39   blue-collar  married   primary      no     774     yes   no   unknown  21   may 2008
## 4920   4920  33    management  married  tertiary      no     188     yes   no   unknown  21   may 2008
## 4921   4921  34      services   single secondary      no    1157     yes   no   unknown  21   may 2008
## 4922   4922  40   blue-collar   single secondary      no    1066     yes   no   unknown  21   may 2008
## 4923   4923  31   blue-collar  married secondary      no     932     yes   no   unknown  21   may 2008
## 4924   4924  32   blue-collar   single   primary      no     557     yes   no   unknown  21   may 2008
## 4925   4925  31    management  married  tertiary      no    1260      no  yes   unknown  21   may 2008
## 4926   4926  35    management   single  tertiary      no    1045     yes   no   unknown  21   may 2008
## 4927   4927  38   blue-collar   single   primary      no     350     yes   no   unknown  21   may 2008
## 4928   4928  48    technician divorced  tertiary      no    -136     yes   no   unknown  21   may 2008
## 4929   4929  37      services  married secondary      no     405     yes   no   unknown  21   may 2008
## 4930   4930  45        admin.  married secondary      no     373     yes   no   unknown  21   may 2008
## 4931   4931  27   blue-collar   single secondary      no       0     yes   no   unknown  21   may 2008
## 4932   4932  33        admin.  married secondary      no    2228     yes   no   unknown  21   may 2008
## 4933   4933  31   blue-collar   single secondary      no      58     yes   no   unknown  21   may 2008
## 4934   4934  33   blue-collar  married secondary      no     932     yes   no   unknown  21   may 2008
## 4935   4935  36    unemployed  married secondary      no    -872     yes  yes   unknown  21   may 2008
## 4936   4936  37    technician  married secondary      no    1450     yes  yes   unknown  21   may 2008
## 4937   4937  37   blue-collar   single secondary      no    2032     yes   no   unknown  21   may 2008
## 4938   4938  32    technician   single  tertiary      no       0     yes   no   unknown  21   may 2008
## 4939   4939  30      services  married  tertiary      no    1380     yes   no   unknown  21   may 2008
## 4940   4940  37    technician  married secondary      no    5729     yes   no   unknown  21   may 2008
## 4941   4941  34    technician   single secondary      no     951     yes   no   unknown  21   may 2008
## 4942   4942  54    management divorced  tertiary      no     487     yes   no   unknown  21   may 2008
## 4943   4943  36        admin.  married secondary      no     957     yes   no   unknown  21   may 2008
## 4944   4944  39       retired  married  tertiary      no     855     yes   no   unknown  21   may 2008
## 4945   4945  36    management  married  tertiary      no     502     yes   no   unknown  21   may 2008
## 4946   4946  37   blue-collar  married   primary      no     204     yes   no   unknown  21   may 2008
## 4947   4947  49   blue-collar divorced   primary      no    2262     yes   no   unknown  21   may 2008
## 4948   4948  31        admin.  married secondary      no    8784     yes   no   unknown  21   may 2008
## 4949   4949  36   blue-collar  married   primary      no     599     yes   no   unknown  21   may 2008
## 4950   4950  31      services  married secondary      no     525     yes  yes   unknown  21   may 2008
## 4951   4951  29        admin.  married secondary      no     688     yes   no   unknown  21   may 2008
## 4952   4952  34    management   single  tertiary      no    1350     yes   no   unknown  21   may 2008
## 4953   4953  32    technician  married secondary      no    1830     yes   no   unknown  21   may 2008
## 4954   4954  31    technician   single  tertiary      no    1887      no  yes   unknown  21   may 2008
## 4955   4955  37   blue-collar   single secondary      no   13156     yes   no   unknown  21   may 2008
## 4956   4956  34   blue-collar  married secondary      no     622     yes   no   unknown  21   may 2008
## 4957   4957  35    management  married  tertiary      no    1336      no   no   unknown  21   may 2008
## 4958   4958  32   blue-collar   single secondary      no    1067     yes   no   unknown  21   may 2008
## 4959   4959  35  entrepreneur   single secondary      no   12961     yes   no   unknown  21   may 2008
## 4960   4960  31    technician  married secondary      no     141     yes   no   unknown  21   may 2008
## 4961   4961  41    management   single  tertiary      no    1216     yes   no   unknown  21   may 2008
## 4962   4962  31      services  married secondary      no     891     yes   no   unknown  21   may 2008
## 4963   4963  32   blue-collar  married   primary      no     131     yes   no   unknown  21   may 2008
## 4964   4964  33    technician  married   primary      no       5      no   no   unknown  21   may 2008
## 4965   4965  52   blue-collar  married secondary      no     289     yes   no   unknown  21   may 2008
## 4966   4966  32   blue-collar   single secondary      no   15341      no   no   unknown  21   may 2008
## 4967   4967  32    technician  married secondary      no     901     yes   no   unknown  21   may 2008
## 4968   4968  32  entrepreneur  married  tertiary      no    4465     yes   no   unknown  21   may 2008
## 4969   4969  34        admin.  married secondary      no    1191     yes   no   unknown  21   may 2008
## 4970   4970  35    technician   single  tertiary      no     458     yes   no   unknown  21   may 2008
## 4971   4971  36    management   single  tertiary      no    1869     yes   no   unknown  21   may 2008
## 4972   4972  37 self-employed  married  tertiary      no    2084     yes   no   unknown  21   may 2008
## 4973   4973  32    technician  married secondary      no    1389     yes   no   unknown  21   may 2008
## 4974   4974  34    management  married  tertiary      no       0     yes   no   unknown  21   may 2008
## 4975   4975  27      services  married secondary      no    1303     yes  yes   unknown  21   may 2008
## 4976   4976  33    management  married  tertiary      no   11149     yes   no   unknown  21   may 2008
## 4977   4977  36    management  married   unknown      no     -35     yes  yes   unknown  21   may 2008
## 4978   4978  37   blue-collar  married   primary      no    3242     yes   no   unknown  21   may 2008
## 4979   4979  32   blue-collar   single secondary      no     435     yes   no   unknown  21   may 2008
## 4980   4980  32   blue-collar   single secondary      no    2696     yes   no   unknown  21   may 2008
## 4981   4981  29   blue-collar   single secondary      no       0      no   no   unknown  21   may 2008
## 4982   4982  34   blue-collar  married   primary      no     218     yes  yes   unknown  21   may 2008
## 4983   4983  33 self-employed divorced secondary      no     892     yes   no   unknown  21   may 2008
## 4984   4984  31    technician  married  tertiary      no    1410     yes   no   unknown  21   may 2008
## 4985   4985  32   blue-collar   single secondary      no    1721     yes   no   unknown  21   may 2008
## 4986   4986  31        admin.   single  tertiary      no    1583     yes   no   unknown  21   may 2008
## 4987   4987  33    technician   single secondary      no     296     yes   no   unknown  21   may 2008
## 4988   4988  38    management  married  tertiary      no     216     yes   no   unknown  21   may 2008
## 4989   4989  35   blue-collar  married secondary      no     463     yes   no   unknown  21   may 2008
## 4990   4990  37    management  married  tertiary      no     547     yes  yes   unknown  21   may 2008
## 4991   4991  42    technician divorced secondary      no    2974     yes   no   unknown  21   may 2008
## 4992   4992  34 self-employed  married secondary      no    -370     yes   no   unknown  21   may 2008
## 4993   4993  32    management  married secondary      no    6217     yes  yes   unknown  21   may 2008
## 4994   4994  28        admin.  married secondary      no     170     yes  yes   unknown  21   may 2008
## 4995   4995  29    management  married secondary      no    -559     yes  yes   unknown  21   may 2008
## 4996   4996  21       student   single secondary      no     232     yes   no   unknown  21   may 2008
## 4997   4997  31    management   single  tertiary      no     385     yes   no   unknown  21   may 2008
## 4998   4998  34   blue-collar  married secondary      no    5304     yes   no   unknown  21   may 2008
## 4999   4999  35    management   single  tertiary      no      71     yes   no   unknown  21   may 2008
##             date duration campaign pdays previous poutcome   y
## 1     2008-05-05      261        1    -1        0  unknown  no
## 2     2008-05-05      151        1    -1        0  unknown  no
## 3     2008-05-05       76        1    -1        0  unknown  no
## 4     2008-05-05       92        1    -1        0  unknown  no
## 5     2008-05-05      198        1    -1        0  unknown  no
## 6     2008-05-05      139        1    -1        0  unknown  no
## 7     2008-05-05      217        1    -1        0  unknown  no
## 8     2008-05-05      380        1    -1        0  unknown  no
## 9     2008-05-05       50        1    -1        0  unknown  no
## 10    2008-05-05       55        1    -1        0  unknown  no
## 11    2008-05-05      222        1    -1        0  unknown  no
## 12    2008-05-05      137        1    -1        0  unknown  no
## 13    2008-05-05      517        1    -1        0  unknown  no
## 14    2008-05-05       71        1    -1        0  unknown  no
## 15    2008-05-05      174        1    -1        0  unknown  no
## 16    2008-05-05      353        1    -1        0  unknown  no
## 17    2008-05-05       98        1    -1        0  unknown  no
## 18    2008-05-05       38        1    -1        0  unknown  no
## 19    2008-05-05      219        1    -1        0  unknown  no
## 20    2008-05-05       54        1    -1        0  unknown  no
## 21    2008-05-05      262        1    -1        0  unknown  no
## 22    2008-05-05      164        1    -1        0  unknown  no
## 23    2008-05-05      160        1    -1        0  unknown  no
## 24    2008-05-05      342        1    -1        0  unknown  no
## 25    2008-05-05      181        1    -1        0  unknown  no
## 26    2008-05-05      172        1    -1        0  unknown  no
## 27    2008-05-05      296        1    -1        0  unknown  no
## 28    2008-05-05      127        1    -1        0  unknown  no
## 29    2008-05-05      255        2    -1        0  unknown  no
## 30    2008-05-05      348        1    -1        0  unknown  no
## 31    2008-05-05      225        1    -1        0  unknown  no
## 32    2008-05-05      230        1    -1        0  unknown  no
## 33    2008-05-05      208        1    -1        0  unknown  no
## 34    2008-05-05      226        1    -1        0  unknown  no
## 35    2008-05-05      336        1    -1        0  unknown  no
## 36    2008-05-05      242        1    -1        0  unknown  no
## 37    2008-05-05      365        1    -1        0  unknown  no
## 38    2008-05-05     1666        1    -1        0  unknown  no
## 39    2008-05-05      577        1    -1        0  unknown  no
## 40    2008-05-05      137        1    -1        0  unknown  no
## 41    2008-05-05      160        1    -1        0  unknown  no
## 42    2008-05-05      180        2    -1        0  unknown  no
## 43    2008-05-05       22        1    -1        0  unknown  no
## 44    2008-05-05     1492        1    -1        0  unknown  no
## 45    2008-05-05      616        1    -1        0  unknown  no
## 46    2008-05-05      242        1    -1        0  unknown  no
## 47    2008-05-05      355        1    -1        0  unknown  no
## 48    2008-05-05      225        2    -1        0  unknown  no
## 49    2008-05-05      160        1    -1        0  unknown  no
## 50    2008-05-05      363        1    -1        0  unknown  no
## 51    2008-05-05      266        1    -1        0  unknown  no
## 52    2008-05-05      253        1    -1        0  unknown  no
## 53    2008-05-05      179        1    -1        0  unknown  no
## 54    2008-05-05      787        1    -1        0  unknown  no
## 55    2008-05-05      145        1    -1        0  unknown  no
## 56    2008-05-05      174        1    -1        0  unknown  no
## 57    2008-05-05      104        1    -1        0  unknown  no
## 58    2008-05-05       13        1    -1        0  unknown  no
## 59    2008-05-05      185        1    -1        0  unknown  no
## 60    2008-05-05     1778        1    -1        0  unknown  no
## 61    2008-05-05      138        1    -1        0  unknown  no
## 62    2008-05-05      812        1    -1        0  unknown  no
## 63    2008-05-05      164        1    -1        0  unknown  no
## 64    2008-05-05      391        1    -1        0  unknown  no
## 65    2008-05-05      357        1    -1        0  unknown  no
## 66    2008-05-05       91        1    -1        0  unknown  no
## 67    2008-05-05      528        1    -1        0  unknown  no
## 68    2008-05-05      273        1    -1        0  unknown  no
## 69    2008-05-05      158        2    -1        0  unknown  no
## 70    2008-05-05      177        1    -1        0  unknown  no
## 71    2008-05-05      258        1    -1        0  unknown  no
## 72    2008-05-05      172        1    -1        0  unknown  no
## 73    2008-05-05      154        1    -1        0  unknown  no
## 74    2008-05-05      291        1    -1        0  unknown  no
## 75    2008-05-05      181        1    -1        0  unknown  no
## 76    2008-05-05      176        1    -1        0  unknown  no
## 77    2008-05-05      211        1    -1        0  unknown  no
## 78    2008-05-05      349        1    -1        0  unknown  no
## 79    2008-05-05      272        1    -1        0  unknown  no
## 80    2008-05-05      208        1    -1        0  unknown  no
## 81    2008-05-05      193        1    -1        0  unknown  no
## 82    2008-05-05      212        1    -1        0  unknown  no
## 83    2008-05-05       20        1    -1        0  unknown  no
## 84    2008-05-05     1042        1    -1        0  unknown yes
## 85    2008-05-05      246        1    -1        0  unknown  no
## 86    2008-05-05      529        2    -1        0  unknown  no
## 87    2008-05-05     1467        1    -1        0  unknown yes
## 88    2008-05-05     1389        1    -1        0  unknown yes
## 89    2008-05-05      188        2    -1        0  unknown  no
## 90    2008-05-05      180        2    -1        0  unknown  no
## 91    2008-05-05       48        1    -1        0  unknown  no
## 92    2008-05-05      213        2    -1        0  unknown  no
## 93    2008-05-05      583        1    -1        0  unknown  no
## 94    2008-05-05      221        1    -1        0  unknown  no
## 95    2008-05-05      173        1    -1        0  unknown  no
## 96    2008-05-05      426        1    -1        0  unknown  no
## 97    2008-05-05      287        1    -1        0  unknown  no
## 98    2008-05-05      101        1    -1        0  unknown  no
## 99    2008-05-05      203        1    -1        0  unknown  no
## 100   2008-05-05      197        1    -1        0  unknown  no
## 101   2008-05-05      257        1    -1        0  unknown  no
## 102   2008-05-05      124        1    -1        0  unknown  no
## 103   2008-05-05      229        1    -1        0  unknown  no
## 104   2008-05-05       55        3    -1        0  unknown  no
## 105   2008-05-05      400        1    -1        0  unknown  no
## 106   2008-05-05      197        1    -1        0  unknown  no
## 107   2008-05-05      190        1    -1        0  unknown  no
## 108   2008-05-05       21        1    -1        0  unknown  no
## 109   2008-05-05      514        1    -1        0  unknown  no
## 110   2008-05-05      849        2    -1        0  unknown  no
## 111   2008-05-05      194        1    -1        0  unknown  no
## 112   2008-05-05      144        1    -1        0  unknown  no
## 113   2008-05-05      212        2    -1        0  unknown  no
## 114   2008-05-05      286        1    -1        0  unknown  no
## 115   2008-05-05      107        1    -1        0  unknown  no
## 116   2008-05-05      247        2    -1        0  unknown  no
## 117   2008-05-05      518        1    -1        0  unknown  no
## 118   2008-05-05      364        1    -1        0  unknown  no
## 119   2008-05-05      178        1    -1        0  unknown  no
## 120   2008-05-05       98        1    -1        0  unknown  no
## 121   2008-05-05      439        1    -1        0  unknown  no
## 122   2008-05-05       79        1    -1        0  unknown  no
## 123   2008-05-05      120        3    -1        0  unknown  no
## 124   2008-05-05      127        2    -1        0  unknown  no
## 125   2008-05-05      175        1    -1        0  unknown  no
## 126   2008-05-05      262        2    -1        0  unknown  no
## 127   2008-05-05       61        1    -1        0  unknown  no
## 128   2008-05-05       78        1    -1        0  unknown  no
## 129   2008-05-05      143        1    -1        0  unknown  no
## 130   2008-05-05      579        1    -1        0  unknown yes
## 131   2008-05-05      677        1    -1        0  unknown  no
## 132   2008-05-05      345        1    -1        0  unknown  no
## 133   2008-05-05      185        1    -1        0  unknown  no
## 134   2008-05-05      100        2    -1        0  unknown  no
## 135   2008-05-05      125        2    -1        0  unknown  no
## 136   2008-05-05      193        1    -1        0  unknown  no
## 137   2008-05-05      136        1    -1        0  unknown  no
## 138   2008-05-05       73        1    -1        0  unknown  no
## 139   2008-05-05      528        1    -1        0  unknown  no
## 140   2008-05-05      541        1    -1        0  unknown  no
## 141   2008-05-05      163        1    -1        0  unknown  no
## 142   2008-05-05      301        1    -1        0  unknown  no
## 143   2008-05-05       46        1    -1        0  unknown  no
## 144   2008-05-05      204        1    -1        0  unknown  no
## 145   2008-05-05       98        1    -1        0  unknown  no
## 146   2008-05-05       71        1    -1        0  unknown  no
## 147   2008-05-05      157        2    -1        0  unknown  no
## 148   2008-05-05      243        1    -1        0  unknown  no
## 149   2008-05-05      186        2    -1        0  unknown  no
## 150   2008-05-05      579        2    -1        0  unknown  no
## 151   2008-05-05      163        2    -1        0  unknown  no
## 152   2008-05-05      610        2    -1        0  unknown  no
## 153   2008-05-05     2033        1    -1        0  unknown  no
## 154   2008-05-05       85        1    -1        0  unknown  no
## 155   2008-05-05      114        2    -1        0  unknown  no
## 156   2008-05-05      114        2    -1        0  unknown  no
## 157   2008-05-05       57        1    -1        0  unknown  no
## 158   2008-05-05      238        1    -1        0  unknown  no
## 159   2008-05-05       93        3    -1        0  unknown  no
## 160   2008-05-05      128        2    -1        0  unknown  no
## 161   2008-05-05      107        1    -1        0  unknown  no
## 162   2008-05-05      181        1    -1        0  unknown  no
## 163   2008-05-05      303        2    -1        0  unknown  no
## 164   2008-05-05      558        5    -1        0  unknown  no
## 165   2008-05-05      270        1    -1        0  unknown  no
## 166   2008-05-05      228        1    -1        0  unknown  no
## 167   2008-05-05       99        1    -1        0  unknown  no
## 168   2008-05-05      240        1    -1        0  unknown  no
## 169   2008-05-05      673        2    -1        0  unknown yes
## 170   2008-05-05      233        3    -1        0  unknown  no
## 171   2008-05-05     1056        1    -1        0  unknown  no
## 172   2008-05-05      250        1    -1        0  unknown  no
## 173   2008-05-05      252        1    -1        0  unknown  no
## 174   2008-05-05      138        1    -1        0  unknown  no
## 175   2008-05-05      130        1    -1        0  unknown  no
## 176   2008-05-05      412        1    -1        0  unknown  no
## 177   2008-05-05      179        2    -1        0  unknown  no
## 178   2008-05-05       19        2    -1        0  unknown  no
## 179   2008-05-05      458        2    -1        0  unknown  no
## 180   2008-05-05      717        1    -1        0  unknown  no
## 181   2008-05-05      313        1    -1        0  unknown  no
## 182   2008-05-05      683        2    -1        0  unknown  no
## 183   2008-05-05     1077        1    -1        0  unknown  no
## 184   2008-05-05      416        1    -1        0  unknown  no
## 185   2008-05-05      146        2    -1        0  unknown  no
## 186   2008-05-05      167        1    -1        0  unknown  no
## 187   2008-05-05      315        1    -1        0  unknown  no
## 188   2008-05-05      140        1    -1        0  unknown  no
## 189   2008-05-05      346        1    -1        0  unknown  no
## 190   2008-05-05      562        1    -1        0  unknown  no
## 191   2008-05-05      172        1    -1        0  unknown  no
## 192   2008-05-05      217        1    -1        0  unknown  no
## 193   2008-05-05      142        2    -1        0  unknown  no
## 194   2008-05-05       67        1    -1        0  unknown  no
## 195   2008-05-05      291        1    -1        0  unknown  no
## 196   2008-05-05      309        2    -1        0  unknown  no
## 197   2008-05-05      248        1    -1        0  unknown  no
## 198   2008-05-05       98        1    -1        0  unknown  no
## 199   2008-05-05      256        1    -1        0  unknown  no
## 200   2008-05-05       82        2    -1        0  unknown  no
## 201   2008-05-05      577        1    -1        0  unknown  no
## 202   2008-05-05      286        1    -1        0  unknown  no
## 203   2008-05-05      477        1    -1        0  unknown  no
## 204   2008-05-05      611        2    -1        0  unknown  no
## 205   2008-05-05      471        1    -1        0  unknown  no
## 206   2008-05-05      381        2    -1        0  unknown  no
## 207   2008-05-05       42        1    -1        0  unknown  no
## 208   2008-05-05      251        1    -1        0  unknown  no
## 209   2008-05-05      408        1    -1        0  unknown  no
## 210   2008-05-05      215        1    -1        0  unknown  no
## 211   2008-05-05      287        1    -1        0  unknown  no
## 212   2008-05-05      216        2    -1        0  unknown  no
## 213   2008-05-05      366        2    -1        0  unknown  no
## 214   2008-05-05      210        1    -1        0  unknown  no
## 215   2008-05-05      288        1    -1        0  unknown  no
## 216   2008-05-05      168        1    -1        0  unknown  no
## 217   2008-05-05      338        2    -1        0  unknown  no
## 218   2008-05-05      410        3    -1        0  unknown  no
## 219   2008-05-05      177        1    -1        0  unknown  no
## 220   2008-05-05      127        2    -1        0  unknown  no
## 221   2008-05-05      357        1    -1        0  unknown  no
## 222   2008-05-05      175        1    -1        0  unknown  no
## 223   2008-05-05      300        1    -1        0  unknown  no
## 224   2008-05-05      136        1    -1        0  unknown  no
## 225   2008-05-05     1419        1    -1        0  unknown  no
## 226   2008-05-05      125        2    -1        0  unknown  no
## 227   2008-05-05      213        3    -1        0  unknown  no
## 228   2008-05-05       27        1    -1        0  unknown  no
## 229   2008-05-05      238        2    -1        0  unknown  no
## 230   2008-05-05      124        1    -1        0  unknown  no
## 231   2008-05-05       18        1    -1        0  unknown  no
## 232   2008-05-05      730        2    -1        0  unknown  no
## 233   2008-05-05      746        2    -1        0  unknown  no
## 234   2008-05-05      121        1    -1        0  unknown  no
## 235   2008-05-05      247        1    -1        0  unknown  no
## 236   2008-05-05       40        1    -1        0  unknown  no
## 237   2008-05-05      181        2    -1        0  unknown  no
## 238   2008-05-05       79        1    -1        0  unknown  no
## 239   2008-05-05      206        1    -1        0  unknown  no
## 240   2008-05-05      389        1    -1        0  unknown  no
## 241   2008-05-05      127        1    -1        0  unknown  no
## 242   2008-05-05      702        1    -1        0  unknown  no
## 243   2008-05-05      151        1    -1        0  unknown  no
## 244   2008-05-05      117        1    -1        0  unknown  no
## 245   2008-05-05      232        3    -1        0  unknown  no
## 246   2008-05-05      408        2    -1        0  unknown  no
## 247   2008-05-05      179        2    -1        0  unknown  no
## 248   2008-05-05       39        1    -1        0  unknown  no
## 249   2008-05-05      282        1    -1        0  unknown  no
## 250   2008-05-05      714        2    -1        0  unknown  no
## 251   2008-05-05       50        1    -1        0  unknown  no
## 252   2008-05-05      181        1    -1        0  unknown  no
## 253   2008-05-05      142        1    -1        0  unknown  no
## 254   2008-05-05      227        1    -1        0  unknown  no
## 255   2008-05-05      119        1    -1        0  unknown  no
## 256   2008-05-05      361        1    -1        0  unknown  no
## 257   2008-05-05       73        3    -1        0  unknown  no
## 258   2008-05-05       67        2    -1        0  unknown  no
## 259   2008-05-05      350        1    -1        0  unknown  no
## 260   2008-05-05      332        2    -1        0  unknown  no
## 261   2008-05-05      611        2    -1        0  unknown  no
## 262   2008-05-05      113        2    -1        0  unknown  no
## 263   2008-05-05      132        1    -1        0  unknown  no
## 264   2008-05-05       58        3    -1        0  unknown  no
## 265   2008-05-05      151        1    -1        0  unknown  no
## 266   2008-05-05       89        2    -1        0  unknown  no
## 267   2008-05-05      152        1    -1        0  unknown  no
## 268   2008-05-05      611        2    -1        0  unknown  no
## 269   2008-05-05      110        2    -1        0  unknown  no
## 270   2008-05-05      463        1    -1        0  unknown  no
## 271   2008-05-05      562        2    -1        0  unknown yes
## 272   2008-05-05      962        1    -1        0  unknown  no
## 273   2008-05-05       10        4    -1        0  unknown  no
## 274   2008-05-05      118        3    -1        0  unknown  no
## 275   2008-05-05       92        2    -1        0  unknown  no
## 276   2008-05-05      143        3    -1        0  unknown  no
## 277   2008-05-05      189        3    -1        0  unknown  no
## 278   2008-05-05      234        2    -1        0  unknown  no
## 279   2008-05-05       75        2    -1        0  unknown  no
## 280   2008-05-05      189        2    -1        0  unknown  no
## 281   2008-05-05      621        3    -1        0  unknown  no
## 282   2008-05-05       55        2    -1        0  unknown  no
## 283   2008-05-05      310        4    -1        0  unknown  no
## 284   2008-05-05      156        2    -1        0  unknown  no
## 285   2008-05-05        5        2    -1        0  unknown  no
## 286   2008-05-05      225        2    -1        0  unknown  no
## 287   2008-05-05      125        2    -1        0  unknown  no
## 288   2008-05-05        2        3    -1        0  unknown  no
## 289   2008-05-05      286        2    -1        0  unknown  no
## 290   2008-05-05      164        2    -1        0  unknown  no
## 291   2008-05-05       98        2    -1        0  unknown  no
## 292   2008-05-05      742        2    -1        0  unknown  no
## 293   2008-05-05      226        3    -1        0  unknown  no
## 294   2008-05-05      120        2    -1        0  unknown  no
## 295   2008-05-05      362        4    -1        0  unknown  no
## 296   2008-05-05      357        2    -1        0  unknown  no
## 297   2008-05-05      200        2    -1        0  unknown  no
## 298   2008-05-05      204        2    -1        0  unknown  no
## 299   2008-05-05      126        3    -1        0  unknown  no
## 300   2008-05-05       65        2    -1        0  unknown  no
## 301   2008-05-05      107        2    -1        0  unknown  no
## 302   2008-05-05      267        2    -1        0  unknown  no
## 303   2008-05-05      248        2    -1        0  unknown  no
## 304   2008-05-05      215        2    -1        0  unknown  no
## 305   2008-05-05      209        2    -1        0  unknown  no
## 306   2008-05-05      205        2    -1        0  unknown  no
## 307   2008-05-05       83        2    -1        0  unknown  no
## 308   2008-05-05      106        3    -1        0  unknown  no
## 309   2008-05-05      189        2    -1        0  unknown  no
## 310   2008-05-05      105        2    -1        0  unknown  no
## 311   2008-05-05      106        2    -1        0  unknown  no
## 312   2008-05-05      108        2    -1        0  unknown  no
## 313   2008-05-05      311        2    -1        0  unknown  no
## 314   2008-05-05      214        2    -1        0  unknown  no
## 315   2008-05-05      132        2    -1        0  unknown  no
## 316   2008-05-05      358        2    -1        0  unknown  no
## 317   2008-05-05      453        2    -1        0  unknown  no
## 318   2008-05-05      364        2    -1        0  unknown  no
## 319   2008-05-05      136        2    -1        0  unknown  no
## 320   2008-05-05      386        2    -1        0  unknown  no
## 321   2008-05-05      173        2    -1        0  unknown  no
## 322   2008-05-05      241        2    -1        0  unknown  no
## 323   2008-05-05      224        3    -1        0  unknown  no
## 324   2008-05-05      148        2    -1        0  unknown  no
## 325   2008-05-05      196        2    -1        0  unknown  no
## 326   2008-05-05      111        4    -1        0  unknown  no
## 327   2008-05-05      231        3    -1        0  unknown  no
## 328   2008-05-05      316        3    -1        0  unknown  no
## 329   2008-05-05      216        3    -1        0  unknown  no
## 330   2008-05-05      240        2    -1        0  unknown  no
## 331   2008-05-05      669        3    -1        0  unknown  no
## 332   2008-05-05      425        2    -1        0  unknown  no
## 333   2008-05-05      143        2    -1        0  unknown  no
## 334   2008-05-05      174        5    -1        0  unknown  no
## 335   2008-05-05      313        3    -1        0  unknown  no
## 336   2008-05-05      135        4    -1        0  unknown  no
## 337   2008-05-05      146        2    -1        0  unknown  no
## 338   2008-05-05      152        2    -1        0  unknown  no
## 339   2008-05-05      402        3    -1        0  unknown  no
## 340   2008-05-05      213        2    -1        0  unknown  no
## 341   2008-05-05      144        3    -1        0  unknown  no
## 342   2008-05-05      124        3    -1        0  unknown  no
## 343   2008-05-05      183        2    -1        0  unknown  no
## 344   2008-05-05      325        2    -1        0  unknown  no
## 345   2008-05-05       39        4    -1        0  unknown  no
## 346   2008-05-05      503        2    -1        0  unknown  no
## 347   2008-05-05       95        4    -1        0  unknown  no
## 348   2008-05-05      680        2    -1        0  unknown  no
## 349   2008-05-05      421        4    -1        0  unknown  no
## 350   2008-05-05      174        3    -1        0  unknown  no
## 351   2008-05-05      113        2    -1        0  unknown  no
## 352   2008-05-05      808        2    -1        0  unknown  no
## 353   2008-05-05      198        3    -1        0  unknown  no
## 354   2008-05-05      195        2    -1        0  unknown  no
## 355   2008-05-05      347        3    -1        0  unknown  no
## 356   2008-05-05      208        2    -1        0  unknown  no
## 357   2008-05-05      404        4    -1        0  unknown  no
## 358   2008-05-05      396        2    -1        0  unknown  no
## 359   2008-05-05      216        4    -1        0  unknown  no
## 360   2008-05-05       98        2    -1        0  unknown  no
## 361   2008-05-05      350        2    -1        0  unknown  no
## 362   2008-05-06      114        2    -1        0  unknown  no
## 363   2008-05-06       88        3    -1        0  unknown  no
## 364   2008-05-06      379        2    -1        0  unknown  no
## 365   2008-05-06      190        3    -1        0  unknown  no
## 366   2008-05-06      158        1    -1        0  unknown  no
## 367   2008-05-06      102        1    -1        0  unknown  no
## 368   2008-05-06      306        1    -1        0  unknown  no
## 369   2008-05-06      218        1    -1        0  unknown  no
## 370   2008-05-06       54        1    -1        0  unknown  no
## 371   2008-05-06      344        1    -1        0  unknown  no
## 372   2008-05-06      195        1    -1        0  unknown  no
## 373   2008-05-06      652        1    -1        0  unknown  no
## 374   2008-05-06      286        1    -1        0  unknown  no
## 375   2008-05-06      189        1    -1        0  unknown  no
## 376   2008-05-06       83        1    -1        0  unknown  no
## 377   2008-05-06      184        2    -1        0  unknown  no
## 378   2008-05-06      235        1    -1        0  unknown  no
## 379   2008-05-06      290        1    -1        0  unknown  no
## 380   2008-05-06      232        1    -1        0  unknown  no
## 381   2008-05-06      133        1    -1        0  unknown  no
## 382   2008-05-06      318        1    -1        0  unknown  no
## 383   2008-05-06      260        3    -1        0  unknown  no
## 384   2008-05-06      437        1    -1        0  unknown  no
## 385   2008-05-06      402        1    -1        0  unknown  no
## 386   2008-05-06       85        1    -1        0  unknown  no
## 387   2008-05-06      125        1    -1        0  unknown  no
## 388   2008-05-06      501        4    -1        0  unknown  no
## 389   2008-05-06     1201        1    -1        0  unknown yes
## 390   2008-05-06      253        1    -1        0  unknown  no
## 391   2008-05-06     1030        1    -1        0  unknown yes
## 392   2008-05-06      149        1    -1        0  unknown  no
## 393   2008-05-06      114        1    -1        0  unknown  no
## 394   2008-05-06      243        1    -1        0  unknown  no
## 395   2008-05-06      769        2    -1        0  unknown  no
## 396   2008-05-06      135        3    -1        0  unknown  no
## 397   2008-05-06      231        1    -1        0  unknown  no
## 398   2008-05-06       76        1    -1        0  unknown  no
## 399   2008-05-06      199        1    -1        0  unknown  no
## 400   2008-05-06      152        1    -1        0  unknown  no
## 401   2008-05-06      124        1    -1        0  unknown  no
## 402   2008-05-06      424        1    -1        0  unknown  no
## 403   2008-05-06       43        1    -1        0  unknown  no
## 404   2008-05-06      154        1    -1        0  unknown  no
## 405   2008-05-06      203        2    -1        0  unknown  no
## 406   2008-05-06      326        1    -1        0  unknown  no
## 407   2008-05-06      393        1    -1        0  unknown  no
## 408   2008-05-06      241        3    -1        0  unknown  no
## 409   2008-05-06      483        1    -1        0  unknown  no
## 410   2008-05-06      259        1    -1        0  unknown  no
## 411   2008-05-06      227        1    -1        0  unknown  no
## 412   2008-05-06      673        1    -1        0  unknown  no
## 413   2008-05-06      576        1    -1        0  unknown  no
## 414   2008-05-06      180        2    -1        0  unknown  no
## 415   2008-05-06      168        2    -1        0  unknown  no
## 416   2008-05-06       90        1    -1        0  unknown  no
## 417   2008-05-06      505        1    -1        0  unknown  no
## 418   2008-05-06      245        1    -1        0  unknown  no
## 419   2008-05-06      186        1    -1        0  unknown  no
## 420   2008-05-06      623        1    -1        0  unknown  no
## 421   2008-05-06      496        3    -1        0  unknown  no
## 422   2008-05-06      118        1    -1        0  unknown  no
## 423   2008-05-06      342        1    -1        0  unknown  no
## 424   2008-05-06      225        1    -1        0  unknown  no
## 425   2008-05-06      185        3    -1        0  unknown  no
## 426   2008-05-06      196        2    -1        0  unknown  no
## 427   2008-05-06      276        1    -1        0  unknown  no
## 428   2008-05-06       76        1    -1        0  unknown  no
## 429   2008-05-06       87        1    -1        0  unknown  no
## 430   2008-05-06      195        1    -1        0  unknown  no
## 431   2008-05-06      744        1    -1        0  unknown  no
## 432   2008-05-06      765        1    -1        0  unknown  no
## 433   2008-05-06      262        1    -1        0  unknown  no
## 434   2008-05-06      119        1    -1        0  unknown  no
## 435   2008-05-06      198        2    -1        0  unknown  no
## 436   2008-05-06      150        1    -1        0  unknown  no
## 437   2008-05-06      241        1    -1        0  unknown  no
## 438   2008-05-06      181        1    -1        0  unknown  no
## 439   2008-05-06      196        1    -1        0  unknown  no
## 440   2008-05-06      149        1    -1        0  unknown  no
## 441   2008-05-06      246        1    -1        0  unknown  no
## 442   2008-05-06      112        1    -1        0  unknown  no
## 443   2008-05-06      309        2    -1        0  unknown  no
## 444   2008-05-06      278        1    -1        0  unknown  no
## 445   2008-05-06      140        1    -1        0  unknown  no
## 446   2008-05-06      136        1    -1        0  unknown  no
## 447   2008-05-06     1623        1    -1        0  unknown yes
## 448   2008-05-06      101        1    -1        0  unknown  no
## 449   2008-05-06      144        1    -1        0  unknown  no
## 450   2008-05-06      238        1    -1        0  unknown  no
## 451   2008-05-06      354        1    -1        0  unknown  no
## 452   2008-05-06       79        1    -1        0  unknown  no
## 453   2008-05-06      187        1    -1        0  unknown  no
## 454   2008-05-06      451        2    -1        0  unknown  no
## 455   2008-05-06      159        1    -1        0  unknown  no
## 456   2008-05-06      409        1    -1        0  unknown  no
## 457   2008-05-06      170        1    -1        0  unknown  no
## 458   2008-05-06      608        1    -1        0  unknown yes
## 459   2008-05-06      243        1    -1        0  unknown  no
## 460   2008-05-06      145        2    -1        0  unknown  no
## 461   2008-05-06      112        1    -1        0  unknown  no
## 462   2008-05-06      262        2    -1        0  unknown  no
## 463   2008-05-06      124        1    -1        0  unknown  no
## 464   2008-05-06       53        1    -1        0  unknown  no
## 465   2008-05-06      134        1    -1        0  unknown  no
## 466   2008-05-06      204        4    -1        0  unknown  no
## 467   2008-05-06      186        1    -1        0  unknown  no
## 468   2008-05-06      678        1    -1        0  unknown  no
## 469   2008-05-06      182        1    -1        0  unknown  no
## 470   2008-05-06      162        1    -1        0  unknown  no
## 471   2008-05-06       27        1    -1        0  unknown  no
## 472   2008-05-06      699        3    -1        0  unknown  no
## 473   2008-05-06       43        1    -1        0  unknown  no
## 474   2008-05-06       97        1    -1        0  unknown  no
## 475   2008-05-06     1677        1    -1        0  unknown yes
## 476   2008-05-06      283        2    -1        0  unknown  no
## 477   2008-05-06      323        1    -1        0  unknown  no
## 478   2008-05-06       82        1    -1        0  unknown  no
## 479   2008-05-06      310        1    -1        0  unknown  no
## 480   2008-05-06      185        1    -1        0  unknown  no
## 481   2008-05-06       47        1    -1        0  unknown  no
## 482   2008-05-06      145        1    -1        0  unknown  no
## 483   2008-05-06      204        1    -1        0  unknown  no
## 484   2008-05-06      187        1    -1        0  unknown  no
## 485   2008-05-06       30        2    -1        0  unknown  no
## 486   2008-05-06      472        1    -1        0  unknown  no
## 487   2008-05-06      448        1    -1        0  unknown  no
## 488   2008-05-06      264        1    -1        0  unknown  no
## 489   2008-05-06      169        1    -1        0  unknown  no
## 490   2008-05-06      288        1    -1        0  unknown  no
## 491   2008-05-06      176        2    -1        0  unknown  no
## 492   2008-05-06      215        1    -1        0  unknown  no
## 493   2008-05-06      337        1    -1        0  unknown  no
## 494   2008-05-06      278        1    -1        0  unknown  no
## 495   2008-05-06      188        2    -1        0  unknown  no
## 496   2008-05-06      174        2    -1        0  unknown  no
## 497   2008-05-06      226        2    -1        0  unknown  no
## 498   2008-05-06      190        1    -1        0  unknown  no
## 499   2008-05-06      111        2    -1        0  unknown  no
## 500   2008-05-06      164        1    -1        0  unknown  no
## 501   2008-05-06      157        2    -1        0  unknown  no
## 502   2008-05-06       46        1    -1        0  unknown  no
## 503   2008-05-06      374        1    -1        0  unknown  no
## 504   2008-05-06      349        1    -1        0  unknown  no
## 505   2008-05-06      325        1    -1        0  unknown  no
## 506   2008-05-06      233        2    -1        0  unknown  no
## 507   2008-05-06      531        1    -1        0  unknown  no
## 508   2008-05-06      153        1    -1        0  unknown  no
## 509   2008-05-06       80        1    -1        0  unknown  no
## 510   2008-05-06      232        1    -1        0  unknown  no
## 511   2008-05-06      118        1    -1        0  unknown  no
## 512   2008-05-06      190        1    -1        0  unknown  no
## 513   2008-05-06      918        1    -1        0  unknown yes
## 514   2008-05-06      238        1    -1        0  unknown  no
## 515   2008-05-06       82        1    -1        0  unknown  no
## 516   2008-05-06      198        3    -1        0  unknown  no
## 517   2008-05-06      160        2    -1        0  unknown  no
## 518   2008-05-06      211        1    -1        0  unknown  no
## 519   2008-05-06      120        1    -1        0  unknown  no
## 520   2008-05-06      136        1    -1        0  unknown  no
## 521   2008-05-06      269        1    -1        0  unknown  no
## 522   2008-05-06      157        1    -1        0  unknown  no
## 523   2008-05-06      128        1    -1        0  unknown  no
## 524   2008-05-06      211        1    -1        0  unknown  no
## 525   2008-05-06      267        2    -1        0  unknown  no
## 526   2008-05-06      371        2    -1        0  unknown  no
## 527   2008-05-06      288        2    -1        0  unknown  no
## 528   2008-05-06      221        1    -1        0  unknown  no
## 529   2008-05-06      427        1    -1        0  unknown  no
## 530   2008-05-06      310        1    -1        0  unknown  no
## 531   2008-05-06      158        1    -1        0  unknown  no
## 532   2008-05-06      604        3    -1        0  unknown  no
## 533   2008-05-06      198        1    -1        0  unknown  no
## 534   2008-05-06      145        1    -1        0  unknown  no
## 535   2008-05-06      247        1    -1        0  unknown  no
## 536   2008-05-06      179        2    -1        0  unknown  no
## 537   2008-05-06       73        1    -1        0  unknown  no
## 538   2008-05-06      263        2    -1        0  unknown  no
## 539   2008-05-06       13        1    -1        0  unknown  no
## 540   2008-05-06       79        2    -1        0  unknown  no
## 541   2008-05-06      416        1    -1        0  unknown  no
## 542   2008-05-06      162        1    -1        0  unknown  no
## 543   2008-05-06      129        1    -1        0  unknown  no
## 544   2008-05-06      150        1    -1        0  unknown  no
## 545   2008-05-06       43        1    -1        0  unknown  no
## 546   2008-05-06      191        1    -1        0  unknown  no
## 547   2008-05-06       26        1    -1        0  unknown  no
## 548   2008-05-06      250        1    -1        0  unknown  no
## 549   2008-05-06      146        1    -1        0  unknown  no
## 550   2008-05-06      416        1    -1        0  unknown  no
## 551   2008-05-06      121        2    -1        0  unknown  no
## 552   2008-05-06      114        2    -1        0  unknown  no
## 553   2008-05-06      289        1    -1        0  unknown  no
## 554   2008-05-06      225        1    -1        0  unknown  no
## 555   2008-05-06      123        1    -1        0  unknown  no
## 556   2008-05-06      130        2    -1        0  unknown  no
## 557   2008-05-06      161        2    -1        0  unknown  no
## 558   2008-05-06      149        2    -1        0  unknown  no
## 559   2008-05-06      268        2    -1        0  unknown  no
## 560   2008-05-06      259        2    -1        0  unknown  no
## 561   2008-05-06       26        1    -1        0  unknown  no
## 562   2008-05-06      153        1    -1        0  unknown  no
## 563   2008-05-06      424        2    -1        0  unknown  no
## 564   2008-05-06      179        2    -1        0  unknown  no
## 565   2008-05-06       97        1    -1        0  unknown  no
## 566   2008-05-06      383        1    -1        0  unknown  no
## 567   2008-05-06      440        1    -1        0  unknown  no
## 568   2008-05-06       23        1    -1        0  unknown  no
## 569   2008-05-06      195        1    -1        0  unknown  no
## 570   2008-05-06     1297        3    -1        0  unknown yes
## 571   2008-05-06       87        1    -1        0  unknown  no
## 572   2008-05-06      427        1    -1        0  unknown  no
## 573   2008-05-06      189        1    -1        0  unknown  no
## 574   2008-05-06      195        1    -1        0  unknown  no
## 575   2008-05-06      179        1    -1        0  unknown  no
## 576   2008-05-06      179        1    -1        0  unknown  no
## 577   2008-05-06       69        1    -1        0  unknown  no
## 578   2008-05-06      105        2    -1        0  unknown  no
## 579   2008-05-06      266        3    -1        0  unknown  no
## 580   2008-05-06      524        2    -1        0  unknown  no
## 581   2008-05-06       96        2    -1        0  unknown  no
## 582   2008-05-06      155        2    -1        0  unknown  no
## 583   2008-05-06      162        2    -1        0  unknown  no
## 584   2008-05-06      352        2    -1        0  unknown  no
## 585   2008-05-06       76        4    -1        0  unknown  no
## 586   2008-05-06      154        2    -1        0  unknown  no
## 587   2008-05-06      310        2    -1        0  unknown  no
## 588   2008-05-06      390        3    -1        0  unknown  no
## 589   2008-05-06      369        1    -1        0  unknown  no
## 590   2008-05-06      112        2    -1        0  unknown  no
## 591   2008-05-06      341        3    -1        0  unknown  no
## 592   2008-05-06       79        1    -1        0  unknown  no
## 593   2008-05-06      140        2    -1        0  unknown  no
## 594   2008-05-06      315        1    -1        0  unknown  no
## 595   2008-05-06      262        2    -1        0  unknown  no
## 596   2008-05-06      174        2    -1        0  unknown  no
## 597   2008-05-06      138        3    -1        0  unknown  no
## 598   2008-05-06      526        2    -1        0  unknown  no
## 599   2008-05-06      135        1    -1        0  unknown  no
## 600   2008-05-06       36        5    -1        0  unknown  no
## 601   2008-05-06     1906        3    -1        0  unknown  no
## 602   2008-05-06      219        2    -1        0  unknown  no
## 603   2008-05-06      147        2    -1        0  unknown  no
## 604   2008-05-06      407        2    -1        0  unknown  no
## 605   2008-05-06      121        1    -1        0  unknown  no
## 606   2008-05-06      209        1    -1        0  unknown  no
## 607   2008-05-06       92        2    -1        0  unknown  no
## 608   2008-05-06      208        1    -1        0  unknown  no
## 609   2008-05-06      193        1    -1        0  unknown  no
## 610   2008-05-06      144        1    -1        0  unknown  no
## 611   2008-05-06       65        1    -1        0  unknown  no
## 612   2008-05-06      339        1    -1        0  unknown  no
## 613   2008-05-06      285        1    -1        0  unknown  no
## 614   2008-05-06      231        1    -1        0  unknown  no
## 615   2008-05-06      168        1    -1        0  unknown  no
## 616   2008-05-06      278        1    -1        0  unknown  no
## 617   2008-05-06      389        1    -1        0  unknown  no
## 618   2008-05-06      158        1    -1        0  unknown  no
## 619   2008-05-06      145        2    -1        0  unknown  no
## 620   2008-05-06       78        2    -1        0  unknown  no
## 621   2008-05-06      142        3    -1        0  unknown  no
## 622   2008-05-06       87        1    -1        0  unknown  no
## 623   2008-05-06      147        2    -1        0  unknown  no
## 624   2008-05-06      289        1    -1        0  unknown  no
## 625   2008-05-06      703        1    -1        0  unknown yes
## 626   2008-05-06      170        3    -1        0  unknown  no
## 627   2008-05-06      802        1    -1        0  unknown  no
## 628   2008-05-06      381        2    -1        0  unknown  no
## 629   2008-05-06      218        4    -1        0  unknown  no
## 630   2008-05-06       57        2    -1        0  unknown  no
## 631   2008-05-06      304        2    -1        0  unknown  no
## 632   2008-05-06      241        3    -1        0  unknown  no
## 633   2008-05-06      230        1    -1        0  unknown  no
## 634   2008-05-06      262        3    -1        0  unknown  no
## 635   2008-05-06      392        2    -1        0  unknown  no
## 636   2008-05-06      201        2    -1        0  unknown  no
## 637   2008-05-06      145        1    -1        0  unknown  no
## 638   2008-05-06      252        1    -1        0  unknown  no
## 639   2008-05-06      235        4    -1        0  unknown  no
## 640   2008-05-06      235        2    -1        0  unknown  no
## 641   2008-05-06      328        2    -1        0  unknown  no
## 642   2008-05-06      116        2    -1        0  unknown  no
## 643   2008-05-06      246        1    -1        0  unknown  no
## 644   2008-05-06      293        1    -1        0  unknown  no
## 645   2008-05-06       37        2    -1        0  unknown  no
## 646   2008-05-06      132        2    -1        0  unknown  no
## 647   2008-05-06      530        2    -1        0  unknown  no
## 648   2008-05-06      175        3    -1        0  unknown  no
## 649   2008-05-06      524        2    -1        0  unknown  no
## 650   2008-05-06       29        3    -1        0  unknown  no
## 651   2008-05-06      311        2    -1        0  unknown  no
## 652   2008-05-06      211        2    -1        0  unknown  no
## 653   2008-05-06      312        3    -1        0  unknown  no
## 654   2008-05-06      412        1    -1        0  unknown  no
## 655   2008-05-06      392        1    -1        0  unknown  no
## 656   2008-05-06      191        1    -1        0  unknown  no
## 657   2008-05-06      284        2    -1        0  unknown  no
## 658   2008-05-06      144        1    -1        0  unknown  no
## 659   2008-05-06      328        1    -1        0  unknown  no
## 660   2008-05-06      100        1    -1        0  unknown  no
## 661   2008-05-06      226        1    -1        0  unknown  no
## 662   2008-05-06      507        1    -1        0  unknown  no
## 663   2008-05-06      392        1    -1        0  unknown  no
## 664   2008-05-06      684        2    -1        0  unknown  no
## 665   2008-05-06      333        2    -1        0  unknown  no
## 666   2008-05-06      311        3    -1        0  unknown  no
## 667   2008-05-06      128        2    -1        0  unknown  no
## 668   2008-05-06      322        2    -1        0  unknown  no
## 669   2008-05-06      202        4    -1        0  unknown  no
## 670   2008-05-06       92        2    -1        0  unknown  no
## 671   2008-05-06      739        3    -1        0  unknown  no
## 672   2008-05-06      273        2    -1        0  unknown  no
## 673   2008-05-06      260        3    -1        0  unknown  no
## 674   2008-05-06      268        2    -1        0  unknown  no
## 675   2008-05-06      396        2    -1        0  unknown  no
## 676   2008-05-06      262        1    -1        0  unknown  no
## 677   2008-05-06      308        3    -1        0  unknown  no
## 678   2008-05-06      467        2    -1        0  unknown  no
## 679   2008-05-06      320        1    -1        0  unknown  no
## 680   2008-05-06      160        3    -1        0  unknown  no
## 681   2008-05-06      245        2    -1        0  unknown  no
## 682   2008-05-06      189        2    -1        0  unknown  no
## 683   2008-05-06      477        1    -1        0  unknown  no
## 684   2008-05-06      310        1    -1        0  unknown  no
## 685   2008-05-06       65        3    -1        0  unknown  no
## 686   2008-05-06      196        2    -1        0  unknown  no
## 687   2008-05-06      221        2    -1        0  unknown  no
## 688   2008-05-06      197        2    -1        0  unknown  no
## 689   2008-05-06      221        2    -1        0  unknown  no
## 690   2008-05-06       64        2    -1        0  unknown  no
## 691   2008-05-06       75        2    -1        0  unknown  no
## 692   2008-05-06      400        2    -1        0  unknown  no
## 693   2008-05-06      378        3    -1        0  unknown  no
## 694   2008-05-06      118        2    -1        0  unknown  no
## 695   2008-05-06     1597        2    -1        0  unknown yes
## 696   2008-05-06      346        2    -1        0  unknown  no
## 697   2008-05-06       60        3    -1        0  unknown  no
## 698   2008-05-06      276        2    -1        0  unknown  no
## 699   2008-05-06      152        2    -1        0  unknown  no
## 700   2008-05-06      251        3    -1        0  unknown  no
## 701   2008-05-06      390        2    -1        0  unknown  no
## 702   2008-05-06      306        2    -1        0  unknown  no
## 703   2008-05-06      189        3    -1        0  unknown  no
## 704   2008-05-06      125        2    -1        0  unknown  no
## 705   2008-05-06      234        2    -1        0  unknown  no
## 706   2008-05-06       79        2    -1        0  unknown  no
## 707   2008-05-06       13        6    -1        0  unknown  no
## 708   2008-05-06      283        3    -1        0  unknown  no
## 709   2008-05-06      109        2    -1        0  unknown  no
## 710   2008-05-06      132        2    -1        0  unknown  no
## 711   2008-05-06      144        2    -1        0  unknown  no
## 712   2008-05-06      121        2    -1        0  unknown  no
## 713   2008-05-06       95        3    -1        0  unknown  no
## 714   2008-05-06       31        3    -1        0  unknown  no
## 715   2008-05-06      112        3    -1        0  unknown  no
## 716   2008-05-06       87        4    -1        0  unknown  no
## 717   2008-05-06      593        2    -1        0  unknown  no
## 718   2008-05-06       99        2    -1        0  unknown  no
## 719   2008-05-06      198        2    -1        0  unknown  no
## 720   2008-05-06      285        2    -1        0  unknown  no
## 721   2008-05-06      190        3    -1        0  unknown  no
## 722   2008-05-06      172        5    -1        0  unknown  no
## 723   2008-05-06      213        3    -1        0  unknown  no
## 724   2008-05-06      178        2    -1        0  unknown  no
## 725   2008-05-06      174        2    -1        0  unknown  no
## 726   2008-05-06      631        2    -1        0  unknown  no
## 727   2008-05-06      176        5    -1        0  unknown  no
## 728   2008-05-06       32        3    -1        0  unknown  no
## 729   2008-05-06     1529        2    -1        0  unknown  no
## 730   2008-05-06      254        2    -1        0  unknown  no
## 731   2008-05-06      200        2    -1        0  unknown  no
## 732   2008-05-06      135        2    -1        0  unknown  no
## 733   2008-05-06      112        4    -1        0  unknown  no
## 734   2008-05-06      314        3    -1        0  unknown  no
## 735   2008-05-06      597        3    -1        0  unknown  no
## 736   2008-05-06      207        3    -1        0  unknown  no
## 737   2008-05-06      410        2    -1        0  unknown  no
## 738   2008-05-06      160        3    -1        0  unknown  no
## 739   2008-05-06       42        3    -1        0  unknown  no
## 740   2008-05-06       55        2    -1        0  unknown  no
## 741   2008-05-06      155        2    -1        0  unknown  no
## 742   2008-05-06      336        3    -1        0  unknown  no
## 743   2008-05-06      233        2    -1        0  unknown  no
## 744   2008-05-06      211        2    -1        0  unknown  no
## 745   2008-05-06       88        5    -1        0  unknown  no
## 746   2008-05-06      208        3    -1        0  unknown  no
## 747   2008-05-06      305        2    -1        0  unknown  no
## 748   2008-05-06      206        2    -1        0  unknown  no
## 749   2008-05-06      128        2    -1        0  unknown  no
## 750   2008-05-06      122        3    -1        0  unknown  no
## 751   2008-05-06       66        3    -1        0  unknown  no
## 752   2008-05-06       66        2    -1        0  unknown  no
## 753   2008-05-06      164        2    -1        0  unknown  no
## 754   2008-05-06      343        3    -1        0  unknown  no
## 755   2008-05-06      126        2    -1        0  unknown  no
## 756   2008-05-06       59        3    -1        0  unknown  no
## 757   2008-05-06      249        3    -1        0  unknown  no
## 758   2008-05-06      406        3    -1        0  unknown  no
## 759   2008-05-06      250        7    -1        0  unknown  no
## 760   2008-05-06      183        5    -1        0  unknown  no
## 761   2008-05-06      190        3    -1        0  unknown  no
## 762   2008-05-06      220        2    -1        0  unknown  no
## 763   2008-05-06      153        3    -1        0  unknown  no
## 764   2008-05-06       95        2    -1        0  unknown  no
## 765   2008-05-06      191        3    -1        0  unknown  no
## 766   2008-05-06      216        2    -1        0  unknown  no
## 767   2008-05-07       89        2    -1        0  unknown  no
## 768   2008-05-07       51        3    -1        0  unknown  no
## 769   2008-05-07      169        3    -1        0  unknown  no
## 770   2008-05-07      148        3    -1        0  unknown  no
## 771   2008-05-07      132        3    -1        0  unknown  no
## 772   2008-05-07      117        3    -1        0  unknown  no
## 773   2008-05-07      275        4    -1        0  unknown  no
## 774   2008-05-07      124        2    -1        0  unknown  no
## 775   2008-05-07      118        3    -1        0  unknown  no
## 776   2008-05-07      479        2    -1        0  unknown  no
## 777   2008-05-07      285        3    -1        0  unknown  no
## 778   2008-05-07       35        4    -1        0  unknown  no
## 779   2008-05-07      322        2    -1        0  unknown  no
## 780   2008-05-07      202        2    -1        0  unknown  no
## 781   2008-05-07      172        8    -1        0  unknown  no
## 782   2008-05-07      201        4    -1        0  unknown  no
## 783   2008-05-07      216        3    -1        0  unknown  no
## 784   2008-05-07      195        2    -1        0  unknown  no
## 785   2008-05-07       96        2    -1        0  unknown  no
## 786   2008-05-07      720        2    -1        0  unknown  no
## 787   2008-05-07      188        2    -1        0  unknown  no
## 788   2008-05-07       70        2    -1        0  unknown  no
## 789   2008-05-07      141        3    -1        0  unknown  no
## 790   2008-05-07      106        1    -1        0  unknown  no
## 791   2008-05-07      395        2    -1        0  unknown  no
## 792   2008-05-07      629        2    -1        0  unknown  no
## 793   2008-05-07      502        1    -1        0  unknown  no
## 794   2008-05-07      446        1    -1        0  unknown  no
## 795   2008-05-07      241        1    -1        0  unknown  no
## 796   2008-05-07      131        3    -1        0  unknown  no
## 797   2008-05-07      312        1    -1        0  unknown  no
## 798   2008-05-07      275        6    -1        0  unknown  no
## 799   2008-05-07      120        2    -1        0  unknown  no
## 800   2008-05-07      333        4    -1        0  unknown  no
## 801   2008-05-07      113        1    -1        0  unknown  no
## 802   2008-05-07       91        1    -1        0  unknown  no
## 803   2008-05-07      128        3    -1        0  unknown  no
## 804   2008-05-07      200        2    -1        0  unknown  no
## 805   2008-05-07      326        1    -1        0  unknown  no
## 806   2008-05-07      292        1    -1        0  unknown  no
## 807   2008-05-07       68        1    -1        0  unknown  no
## 808   2008-05-07      215        1    -1        0  unknown  no
## 809   2008-05-07       97        1    -1        0  unknown  no
## 810   2008-05-07       32        1    -1        0  unknown  no
## 811   2008-05-07      162        1    -1        0  unknown  no
## 812   2008-05-07      152        3    -1        0  unknown  no
## 813   2008-05-07      268        1    -1        0  unknown  no
## 814   2008-05-07      104        2    -1        0  unknown  no
## 815   2008-05-07      852        1    -1        0  unknown  no
## 816   2008-05-07      923        3    -1        0  unknown  no
## 817   2008-05-07      159        2    -1        0  unknown  no
## 818   2008-05-07      953        3    -1        0  unknown  no
## 819   2008-05-07      416        2    -1        0  unknown  no
## 820   2008-05-07      174        1    -1        0  unknown  no
## 821   2008-05-07      180        1    -1        0  unknown  no
## 822   2008-05-07      139        1    -1        0  unknown  no
## 823   2008-05-07      294        1    -1        0  unknown  no
## 824   2008-05-07      102        1    -1        0  unknown  no
## 825   2008-05-07      124        1    -1        0  unknown  no
## 826   2008-05-07      128        1    -1        0  unknown  no
## 827   2008-05-07      130        1    -1        0  unknown  no
## 828   2008-05-07      143        1    -1        0  unknown  no
## 829   2008-05-07       74        1    -1        0  unknown  no
## 830   2008-05-07      105        2    -1        0  unknown  no
## 831   2008-05-07      477        2    -1        0  unknown  no
## 832   2008-05-07      158        1    -1        0  unknown  no
## 833   2008-05-07      250        1    -1        0  unknown  no
## 834   2008-05-07      168        1    -1        0  unknown  no
## 835   2008-05-07      520        1    -1        0  unknown  no
## 836   2008-05-07      171        1    -1        0  unknown  no
## 837   2008-05-07      113        1    -1        0  unknown  no
## 838   2008-05-07      254        1    -1        0  unknown  no
## 839   2008-05-07      149        1    -1        0  unknown  no
## 840   2008-05-07      133        2    -1        0  unknown  no
## 841   2008-05-07      293        3    -1        0  unknown  no
## 842   2008-05-07      485        1    -1        0  unknown  no
## 843   2008-05-07      374        1    -1        0  unknown  no
## 844   2008-05-07      425        6    -1        0  unknown  no
## 845   2008-05-07      207        1    -1        0  unknown  no
## 846   2008-05-07       83        3    -1        0  unknown  no
## 847   2008-05-07      228        1    -1        0  unknown  no
## 848   2008-05-07      149        1    -1        0  unknown  no
## 849   2008-05-07      139        1    -1        0  unknown  no
## 850   2008-05-07      732        2    -1        0  unknown yes
## 851   2008-05-07      142        1    -1        0  unknown  no
## 852   2008-05-07      359        1    -1        0  unknown  no
## 853   2008-05-07      112        1    -1        0  unknown  no
## 854   2008-05-07     1521        1    -1        0  unknown  no
## 855   2008-05-07      216        1    -1        0  unknown  no
## 856   2008-05-07      161        1    -1        0  unknown  no
## 857   2008-05-07      122        2    -1        0  unknown  no
## 858   2008-05-07      800        1    -1        0  unknown  no
## 859   2008-05-07      615        1    -1        0  unknown  no
## 860   2008-05-07      254        1    -1        0  unknown  no
## 861   2008-05-07      111        1    -1        0  unknown  no
## 862   2008-05-07      354        1    -1        0  unknown  no
## 863   2008-05-07      359        1    -1        0  unknown  no
## 864   2008-05-07       97        1    -1        0  unknown  no
## 865   2008-05-07      327        3    -1        0  unknown  no
## 866   2008-05-07      236        1    -1        0  unknown  no
## 867   2008-05-07      160        1    -1        0  unknown  no
## 868   2008-05-07      180        1    -1        0  unknown  no
## 869   2008-05-07      184        1    -1        0  unknown  no
## 870   2008-05-07      227        1    -1        0  unknown  no
## 871   2008-05-07      109        1    -1        0  unknown  no
## 872   2008-05-07      492        2    -1        0  unknown  no
## 873   2008-05-07      298        1    -1        0  unknown  no
## 874   2008-05-07       83        2    -1        0  unknown  no
## 875   2008-05-07      241        2    -1        0  unknown  no
## 876   2008-05-07      204        2    -1        0  unknown  no
## 877   2008-05-07      131        1    -1        0  unknown  no
## 878   2008-05-07     1138        1    -1        0  unknown yes
## 879   2008-05-07      123        1    -1        0  unknown  no
## 880   2008-05-07      125        1    -1        0  unknown  no
## 881   2008-05-07      295        2    -1        0  unknown  no
## 882   2008-05-07      287        1    -1        0  unknown  no
## 883   2008-05-07      109        1    -1        0  unknown  no
## 884   2008-05-07      140        2    -1        0  unknown  no
## 885   2008-05-07      204        1    -1        0  unknown  no
## 886   2008-05-07      233        1    -1        0  unknown  no
## 887   2008-05-07      254        1    -1        0  unknown  no
## 888   2008-05-07      184        2    -1        0  unknown  no
## 889   2008-05-07      193        1    -1        0  unknown  no
## 890   2008-05-07      126        1    -1        0  unknown  no
## 891   2008-05-07      230        1    -1        0  unknown  no
## 892   2008-05-07      591        1    -1        0  unknown yes
## 893   2008-05-07      294        1    -1        0  unknown  no
## 894   2008-05-07      173        1    -1        0  unknown  no
## 895   2008-05-07      336        1    -1        0  unknown  no
## 896   2008-05-07       19        1    -1        0  unknown  no
## 897   2008-05-07      153        1    -1        0  unknown  no
## 898   2008-05-07      786        1    -1        0  unknown yes
## 899   2008-05-07       99        2    -1        0  unknown  no
## 900   2008-05-07      243        1    -1        0  unknown  no
## 901   2008-05-07      260        1    -1        0  unknown  no
## 902   2008-05-07      164        2    -1        0  unknown  no
## 903   2008-05-07      255        2    -1        0  unknown  no
## 904   2008-05-07       47        1    -1        0  unknown  no
## 905   2008-05-07      463        1    -1        0  unknown  no
## 906   2008-05-07      192        1    -1        0  unknown  no
## 907   2008-05-07      388        7    -1        0  unknown  no
## 908   2008-05-07      221        1    -1        0  unknown  no
## 909   2008-05-07      126        5    -1        0  unknown  no
## 910   2008-05-07      175        5    -1        0  unknown  no
## 911   2008-05-07      256        6    -1        0  unknown  no
## 912   2008-05-07      202        2    -1        0  unknown  no
## 913   2008-05-07      104        1    -1        0  unknown  no
## 914   2008-05-07      283        2    -1        0  unknown  no
## 915   2008-05-07      448        1    -1        0  unknown  no
## 916   2008-05-07      127        1    -1        0  unknown  no
## 917   2008-05-07      378        1    -1        0  unknown  no
## 918   2008-05-07       67        1    -1        0  unknown  no
## 919   2008-05-07      221        2    -1        0  unknown  no
## 920   2008-05-07      150        1    -1        0  unknown  no
## 921   2008-05-07      144        2    -1        0  unknown  no
## 922   2008-05-07      296        2    -1        0  unknown  no
## 923   2008-05-07      401        2    -1        0  unknown  no
## 924   2008-05-07      435        2    -1        0  unknown  no
## 925   2008-05-07      388        1    -1        0  unknown  no
## 926   2008-05-07      245        1    -1        0  unknown  no
## 927   2008-05-07      143        1    -1        0  unknown  no
## 928   2008-05-07      223        2    -1        0  unknown  no
## 929   2008-05-07      423        1    -1        0  unknown  no
## 930   2008-05-07      231        1    -1        0  unknown  no
## 931   2008-05-07      634        2    -1        0  unknown  no
## 932   2008-05-07      107        1    -1        0  unknown  no
## 933   2008-05-07      227        1    -1        0  unknown  no
## 934   2008-05-07       69        1    -1        0  unknown  no
## 935   2008-05-07      799        1    -1        0  unknown  no
## 936   2008-05-07      109        1    -1        0  unknown  no
## 937   2008-05-07      127        1    -1        0  unknown  no
## 938   2008-05-07      120        1    -1        0  unknown  no
## 939   2008-05-07       68        3    -1        0  unknown  no
## 940   2008-05-07      180        2    -1        0  unknown  no
## 941   2008-05-07      112        3    -1        0  unknown  no
## 942   2008-05-07      444        1    -1        0  unknown  no
## 943   2008-05-07      246        2    -1        0  unknown  no
## 944   2008-05-07      259        4    -1        0  unknown  no
## 945   2008-05-07      223        3    -1        0  unknown  no
## 946   2008-05-07      566        2    -1        0  unknown  no
## 947   2008-05-07      274        2    -1        0  unknown  no
## 948   2008-05-07       49        3    -1        0  unknown  no
## 949   2008-05-07      380        2    -1        0  unknown  no
## 950   2008-05-07      138        1    -1        0  unknown  no
## 951   2008-05-07      376        2    -1        0  unknown  no
## 952   2008-05-07      421        2    -1        0  unknown  no
## 953   2008-05-07      121        2    -1        0  unknown  no
## 954   2008-05-07       36        1    -1        0  unknown  no
## 955   2008-05-07      328        2    -1        0  unknown  no
## 956   2008-05-07       19        1    -1        0  unknown  no
## 957   2008-05-07      866        2    -1        0  unknown  no
## 958   2008-05-07      229        3    -1        0  unknown  no
## 959   2008-05-07      154        2    -1        0  unknown  no
## 960   2008-05-07       56        1    -1        0  unknown  no
## 961   2008-05-07     1581        2    -1        0  unknown  no
## 962   2008-05-07      117        1    -1        0  unknown  no
## 963   2008-05-07      185        1    -1        0  unknown  no
## 964   2008-05-07      202        1    -1        0  unknown  no
## 965   2008-05-07      279        1    -1        0  unknown  no
## 966   2008-05-07      180        5    -1        0  unknown  no
## 967   2008-05-07      218        4    -1        0  unknown  no
## 968   2008-05-07      129        5    -1        0  unknown  no
## 969   2008-05-07      530        2    -1        0  unknown  no
## 970   2008-05-07      104        2    -1        0  unknown  no
## 971   2008-05-07       60        1    -1        0  unknown  no
## 972   2008-05-07      432        1    -1        0  unknown  no
## 973   2008-05-07      113        1    -1        0  unknown  no
## 974   2008-05-07      516        1    -1        0  unknown  no
## 975   2008-05-07      179        2    -1        0  unknown  no
## 976   2008-05-07      125        2    -1        0  unknown  no
## 977   2008-05-07      386        2    -1        0  unknown  no
## 978   2008-05-07      262        2    -1        0  unknown  no
## 979   2008-05-07      396        2    -1        0  unknown  no
## 980   2008-05-07      294        2    -1        0  unknown  no
## 981   2008-05-07      171        2    -1        0  unknown  no
## 982   2008-05-07      614        2    -1        0  unknown  no
## 983   2008-05-07      118        3    -1        0  unknown  no
## 984   2008-05-07      485        4    -1        0  unknown  no
## 985   2008-05-07      406        2    -1        0  unknown  no
## 986   2008-05-07      287        1    -1        0  unknown  no
## 987   2008-05-07      216        2    -1        0  unknown  no
## 988   2008-05-07      650        1    -1        0  unknown  no
## 989   2008-05-07       55        1    -1        0  unknown  no
## 990   2008-05-07      371        2    -1        0  unknown  no
## 991   2008-05-07      166        1    -1        0  unknown  no
## 992   2008-05-07       48        1    -1        0  unknown  no
## 993   2008-05-07       72        1    -1        0  unknown  no
## 994   2008-05-07       55        1    -1        0  unknown  no
## 995   2008-05-07      144        1    -1        0  unknown  no
## 996   2008-05-07      474        1    -1        0  unknown  no
## 997   2008-05-07      559        1    -1        0  unknown  no
## 998   2008-05-07      261        1    -1        0  unknown  no
## 999   2008-05-07     1101        1    -1        0  unknown  no
## 1000  2008-05-07      236        2    -1        0  unknown  no
## 1001  2008-05-07      164        1    -1        0  unknown  no
## 1002  2008-05-07       93        1    -1        0  unknown  no
## 1003  2008-05-07      912        2    -1        0  unknown  no
## 1004  2008-05-07      179        2    -1        0  unknown  no
## 1005  2008-05-07      485        1    -1        0  unknown  no
## 1006  2008-05-07      206        2    -1        0  unknown  no
## 1007  2008-05-07      311        1    -1        0  unknown  no
## 1008  2008-05-07      690        2    -1        0  unknown  no
## 1009  2008-05-07      362        1    -1        0  unknown  no
## 1010  2008-05-07      274        1    -1        0  unknown  no
## 1011  2008-05-07      163        1    -1        0  unknown  no
## 1012  2008-05-07      345        1    -1        0  unknown  no
## 1013  2008-05-07      329        1    -1        0  unknown  no
## 1014  2008-05-07       68        1    -1        0  unknown  no
## 1015  2008-05-07      143        3    -1        0  unknown  no
## 1016  2008-05-07     1062        1    -1        0  unknown  no
## 1017  2008-05-07       71        1    -1        0  unknown  no
## 1018  2008-05-07      106        1    -1        0  unknown  no
## 1019  2008-05-07      688        2    -1        0  unknown  no
## 1020  2008-05-07      103        3    -1        0  unknown  no
## 1021  2008-05-07      349        2    -1        0  unknown  no
## 1022  2008-05-07       78        5    -1        0  unknown  no
## 1023  2008-05-07      194        1    -1        0  unknown  no
## 1024  2008-05-07      224        5    -1        0  unknown  no
## 1025  2008-05-07       98        1    -1        0  unknown  no
## 1026  2008-05-07      607        1    -1        0  unknown  no
## 1027  2008-05-07      398        1    -1        0  unknown  no
## 1028  2008-05-07      103        2    -1        0  unknown  no
## 1029  2008-05-07      241        2    -1        0  unknown  no
## 1030  2008-05-07      203        1    -1        0  unknown  no
## 1031  2008-05-07       96        3    -1        0  unknown  no
## 1032  2008-05-07      238        3    -1        0  unknown  no
## 1033  2008-05-07      153        3    -1        0  unknown  no
## 1034  2008-05-07      481        1    -1        0  unknown  no
## 1035  2008-05-07     2177        4    -1        0  unknown  no
## 1036  2008-05-07      119        3    -1        0  unknown  no
## 1037  2008-05-07      245        2    -1        0  unknown  no
## 1038  2008-05-07      152        2    -1        0  unknown  no
## 1039  2008-05-07      418        2    -1        0  unknown  no
## 1040  2008-05-07      198        2    -1        0  unknown  no
## 1041  2008-05-07      198        2    -1        0  unknown  no
## 1042  2008-05-07      374        1    -1        0  unknown  no
## 1043  2008-05-07       51        1    -1        0  unknown  no
## 1044  2008-05-07      263        1    -1        0  unknown  no
## 1045  2008-05-07      229        2    -1        0  unknown  no
## 1046  2008-05-07      154        2    -1        0  unknown  no
## 1047  2008-05-07      278        6    -1        0  unknown  no
## 1048  2008-05-07      306        5    -1        0  unknown  no
## 1049  2008-05-07      114        2    -1        0  unknown  no
## 1050  2008-05-07       94        2    -1        0  unknown  no
## 1051  2008-05-07      208        2    -1        0  unknown  no
## 1052  2008-05-07      169        2    -1        0  unknown  no
## 1053  2008-05-07      332        2    -1        0  unknown  no
## 1054  2008-05-07      263        6    -1        0  unknown  no
## 1055  2008-05-07      353        3    -1        0  unknown  no
## 1056  2008-05-07      108        6    -1        0  unknown  no
## 1057  2008-05-07      441        2    -1        0  unknown  no
## 1058  2008-05-07       46        3    -1        0  unknown  no
## 1059  2008-05-07      266        2    -1        0  unknown  no
## 1060  2008-05-07      223        2    -1        0  unknown  no
## 1061  2008-05-07      105        2    -1        0  unknown  no
## 1062  2008-05-07      165        3    -1        0  unknown  no
## 1063  2008-05-07      381        2    -1        0  unknown  no
## 1064  2008-05-07      228        3    -1        0  unknown  no
## 1065  2008-05-07      128        2    -1        0  unknown  no
## 1066  2008-05-07      764        3    -1        0  unknown  no
## 1067  2008-05-07      113        3    -1        0  unknown  no
## 1068  2008-05-07      396        4    -1        0  unknown  no
## 1069  2008-05-07      133        3    -1        0  unknown  no
## 1070  2008-05-07       42        2    -1        0  unknown  no
## 1071  2008-05-07      234        4    -1        0  unknown  no
## 1072  2008-05-07      297        3    -1        0  unknown  no
## 1073  2008-05-07       50        2    -1        0  unknown  no
## 1074  2008-05-07      214        2    -1        0  unknown  no
## 1075  2008-05-07      110        2    -1        0  unknown  no
## 1076  2008-05-07       99        2    -1        0  unknown  no
## 1077  2008-05-07      274        4    -1        0  unknown  no
## 1078  2008-05-07      191        4    -1        0  unknown  no
## 1079  2008-05-07      305        3    -1        0  unknown  no
## 1080  2008-05-07      134        2    -1        0  unknown  no
## 1081  2008-05-07      112        4    -1        0  unknown  no
## 1082  2008-05-07      283        3    -1        0  unknown  no
## 1083  2008-05-07      353        4    -1        0  unknown  no
## 1084  2008-05-07      212        2    -1        0  unknown  no
## 1085  2008-05-07      225        2    -1        0  unknown  no
## 1086  2008-05-07      283        1    -1        0  unknown  no
## 1087  2008-05-07     1273        1    -1        0  unknown  no
## 1088  2008-05-07     1574        2    -1        0  unknown yes
## 1089  2008-05-07      139        3    -1        0  unknown  no
## 1090  2008-05-07      228        2    -1        0  unknown  no
## 1091  2008-05-07       62        5    -1        0  unknown  no
## 1092  2008-05-07      256        3    -1        0  unknown  no
## 1093  2008-05-07      564        3    -1        0  unknown  no
## 1094  2008-05-07      245        2    -1        0  unknown  no
## 1095  2008-05-07      161        2    -1        0  unknown  no
## 1096  2008-05-07       79        4    -1        0  unknown  no
## 1097  2008-05-07      152        3    -1        0  unknown  no
## 1098  2008-05-07      591        3    -1        0  unknown  no
## 1099  2008-05-07      113        2    -1        0  unknown  no
## 1100  2008-05-07      193        3    -1        0  unknown  no
## 1101  2008-05-07      299        2    -1        0  unknown  no
## 1102  2008-05-07      348        3    -1        0  unknown  no
## 1103  2008-05-07      103        4    -1        0  unknown  no
## 1104  2008-05-07      253        8    -1        0  unknown  no
## 1105  2008-05-07      127        2    -1        0  unknown  no
## 1106  2008-05-07      244        7    -1        0  unknown  no
## 1107  2008-05-07      157        6    -1        0  unknown  no
## 1108  2008-05-07      548        2    -1        0  unknown  no
## 1109  2008-05-07      114        3    -1        0  unknown  no
## 1110  2008-05-07      126        5    -1        0  unknown  no
## 1111  2008-05-07      161        3    -1        0  unknown  no
## 1112  2008-05-07      333        1    -1        0  unknown  no
## 1113  2008-05-07      155        1    -1        0  unknown  no
## 1114  2008-05-07      152        3    -1        0  unknown  no
## 1115  2008-05-07      145        1    -1        0  unknown  no
## 1116  2008-05-07       66        3    -1        0  unknown  no
## 1117  2008-05-07      123        2    -1        0  unknown  no
## 1118  2008-05-07       74        1    -1        0  unknown  no
## 1119  2008-05-07      248        3    -1        0  unknown  no
## 1120  2008-05-07      130        1    -1        0  unknown  no
## 1121  2008-05-07       71        1    -1        0  unknown  no
## 1122  2008-05-07      984        1    -1        0  unknown  no
## 1123  2008-05-07      252        1    -1        0  unknown  no
## 1124  2008-05-07       84        2    -1        0  unknown  no
## 1125  2008-05-07     1689        4    -1        0  unknown yes
## 1126  2008-05-07      130        4    -1        0  unknown  no
## 1127  2008-05-07      489        2    -1        0  unknown  no
## 1128  2008-05-07       41        3    -1        0  unknown  no
## 1129  2008-05-07      159        3    -1        0  unknown  no
## 1130  2008-05-07      196        2    -1        0  unknown  no
## 1131  2008-05-07      276        4    -1        0  unknown  no
## 1132  2008-05-07      697        2    -1        0  unknown  no
## 1133  2008-05-07       81        2    -1        0  unknown  no
## 1134  2008-05-07      149        1    -1        0  unknown  no
## 1135  2008-05-07      281        2    -1        0  unknown  no
## 1136  2008-05-07      122        5    -1        0  unknown  no
## 1137  2008-05-07      361        2    -1        0  unknown  no
## 1138  2008-05-07      319        3    -1        0  unknown  no
## 1139  2008-05-07      944        3    -1        0  unknown  no
## 1140  2008-05-07      282        2    -1        0  unknown  no
## 1141  2008-05-07     1102        2    -1        0  unknown yes
## 1142  2008-05-07       35        3    -1        0  unknown  no
## 1143  2008-05-07      143        2    -1        0  unknown  no
## 1144  2008-05-07       22        2    -1        0  unknown  no
## 1145  2008-05-07       90        2    -1        0  unknown  no
## 1146  2008-05-07       17        2    -1        0  unknown  no
## 1147  2008-05-07      404        5    -1        0  unknown  no
## 1148  2008-05-07      238        2    -1        0  unknown  no
## 1149  2008-05-07       71        4    -1        0  unknown  no
## 1150  2008-05-07      309        2    -1        0  unknown  no
## 1151  2008-05-07      408        3    -1        0  unknown  no
## 1152  2008-05-07      128        4    -1        0  unknown  no
## 1153  2008-05-07      297        3    -1        0  unknown  no
## 1154  2008-05-07      280        3    -1        0  unknown  no
## 1155  2008-05-07      374        2    -1        0  unknown  no
## 1156  2008-05-07      365        4    -1        0  unknown  no
## 1157  2008-05-08      177        3    -1        0  unknown  no
## 1158  2008-05-08      238        3    -1        0  unknown  no
## 1159  2008-05-08      425        6    -1        0  unknown  no
## 1160  2008-05-08       77        2    -1        0  unknown  no
## 1161  2008-05-08      223        2    -1        0  unknown  no
## 1162  2008-05-08      201        2    -1        0  unknown  no
## 1163  2008-05-08      239        2    -1        0  unknown  no
## 1164  2008-05-08      308        3    -1        0  unknown  no
## 1165  2008-05-08      137        2    -1        0  unknown  no
## 1166  2008-05-08      162        2    -1        0  unknown  no
## 1167  2008-05-08      134        1    -1        0  unknown  no
## 1168  2008-05-08      175        5    -1        0  unknown  no
## 1169  2008-05-08      125        3    -1        0  unknown  no
## 1170  2008-05-08      211        3    -1        0  unknown  no
## 1171  2008-05-08       67        1    -1        0  unknown  no
## 1172  2008-05-08      156        1    -1        0  unknown  no
## 1173  2008-05-08      943        2    -1        0  unknown yes
## 1174  2008-05-08      813        1    -1        0  unknown yes
## 1175  2008-05-08      178        1    -1        0  unknown  no
## 1176  2008-05-08      142        1    -1        0  unknown  no
## 1177  2008-05-08      194        1    -1        0  unknown  no
## 1178  2008-05-08      132        1    -1        0  unknown  no
## 1179  2008-05-08      109        1    -1        0  unknown  no
## 1180  2008-05-08       94        1    -1        0  unknown  no
## 1181  2008-05-08       31        1    -1        0  unknown  no
## 1182  2008-05-08       84        4    -1        0  unknown  no
## 1183  2008-05-08      489        1    -1        0  unknown  no
## 1184  2008-05-08      180        1    -1        0  unknown  no
## 1185  2008-05-08      314        1    -1        0  unknown  no
## 1186  2008-05-08      207        1    -1        0  unknown  no
## 1187  2008-05-08      146        3    -1        0  unknown  no
## 1188  2008-05-08      193        1    -1        0  unknown  no
## 1189  2008-05-08      177        2    -1        0  unknown  no
## 1190  2008-05-08     1040        1    -1        0  unknown  no
## 1191  2008-05-08      622        1    -1        0  unknown  no
## 1192  2008-05-08      170        2    -1        0  unknown  no
## 1193  2008-05-08      267        1    -1        0  unknown  no
## 1194  2008-05-08     1084        1    -1        0  unknown yes
## 1195  2008-05-08      528        1    -1        0  unknown  no
## 1196  2008-05-08      183        1    -1        0  unknown  no
## 1197  2008-05-08      238        1    -1        0  unknown  no
## 1198  2008-05-08       61        1    -1        0  unknown  no
## 1199  2008-05-08      923        1    -1        0  unknown  no
## 1200  2008-05-08       70        1    -1        0  unknown  no
## 1201  2008-05-08      541        3    -1        0  unknown yes
## 1202  2008-05-08       41        1    -1        0  unknown  no
## 1203  2008-05-08      221        4    -1        0  unknown  no
## 1204  2008-05-08       35        1    -1        0  unknown  no
## 1205  2008-05-08      262        1    -1        0  unknown  no
## 1206  2008-05-08      151        1    -1        0  unknown  no
## 1207  2008-05-08      135        2    -1        0  unknown  no
## 1208  2008-05-08      604        1    -1        0  unknown  no
## 1209  2008-05-08       65        1    -1        0  unknown  no
## 1210  2008-05-08      380        3    -1        0  unknown  no
## 1211  2008-05-08      693        1    -1        0  unknown  no
## 1212  2008-05-08       11        1    -1        0  unknown  no
## 1213  2008-05-08      405        1    -1        0  unknown  no
## 1214  2008-05-08       20        1    -1        0  unknown  no
## 1215  2008-05-08      202        1    -1        0  unknown  no
## 1216  2008-05-08      235        1    -1        0  unknown  no
## 1217  2008-05-08       75        1    -1        0  unknown  no
## 1218  2008-05-08      134        1    -1        0  unknown  no
## 1219  2008-05-08      101        2    -1        0  unknown  no
## 1220  2008-05-08      255        1    -1        0  unknown  no
## 1221  2008-05-08       80        1    -1        0  unknown  no
## 1222  2008-05-08      462        1    -1        0  unknown  no
## 1223  2008-05-08      161        3    -1        0  unknown  no
## 1224  2008-05-08      200        1    -1        0  unknown  no
## 1225  2008-05-08       56        1    -1        0  unknown  no
## 1226  2008-05-08      238        1    -1        0  unknown  no
## 1227  2008-05-08      418        1    -1        0  unknown  no
## 1228  2008-05-08      139        2    -1        0  unknown  no
## 1229  2008-05-08       96        2    -1        0  unknown  no
## 1230  2008-05-08       39        1    -1        0  unknown  no
## 1231  2008-05-08      471        1    -1        0  unknown  no
## 1232  2008-05-08      231        2    -1        0  unknown  no
## 1233  2008-05-08       66        2    -1        0  unknown  no
## 1234  2008-05-08      204        1    -1        0  unknown  no
## 1235  2008-05-08      159        1    -1        0  unknown  no
## 1236  2008-05-08      200        1    -1        0  unknown  no
## 1237  2008-05-08      187        3    -1        0  unknown  no
## 1238  2008-05-08      166        1    -1        0  unknown  no
## 1239  2008-05-08      144        1    -1        0  unknown  no
## 1240  2008-05-08      690        1    -1        0  unknown  no
## 1241  2008-05-08      323        1    -1        0  unknown  no
## 1242  2008-05-08      194        1    -1        0  unknown  no
## 1243  2008-05-08       82        1    -1        0  unknown  no
## 1244  2008-05-08      269        1    -1        0  unknown  no
## 1245  2008-05-08      285        1    -1        0  unknown  no
## 1246  2008-05-08      101        1    -1        0  unknown  no
## 1247  2008-05-08      294        1    -1        0  unknown  no
## 1248  2008-05-08     1119        1    -1        0  unknown yes
## 1249  2008-05-08      249        1    -1        0  unknown  no
## 1250  2008-05-08      106        1    -1        0  unknown  no
## 1251  2008-05-08      152        1    -1        0  unknown  no
## 1252  2008-05-08       12        2    -1        0  unknown  no
## 1253  2008-05-08      187        1    -1        0  unknown  no
## 1254  2008-05-08      214        2    -1        0  unknown  no
## 1255  2008-05-08      268        1    -1        0  unknown  no
## 1256  2008-05-08      193        1    -1        0  unknown  no
## 1257  2008-05-08       95        1    -1        0  unknown  no
## 1258  2008-05-08       60        1    -1        0  unknown  no
## 1259  2008-05-08      381        1    -1        0  unknown  no
## 1260  2008-05-08      206        1    -1        0  unknown  no
## 1261  2008-05-08       75        1    -1        0  unknown  no
## 1262  2008-05-08      128        1    -1        0  unknown  no
## 1263  2008-05-08      216        1    -1        0  unknown  no
## 1264  2008-05-08      155        1    -1        0  unknown  no
## 1265  2008-05-08      103        3    -1        0  unknown  no
## 1266  2008-05-08      494        1    -1        0  unknown  no
## 1267  2008-05-08      107        1    -1        0  unknown  no
## 1268  2008-05-08      147        1    -1        0  unknown  no
## 1269  2008-05-08      190        1    -1        0  unknown  no
## 1270  2008-05-08      339        2    -1        0  unknown  no
## 1271  2008-05-08      198        1    -1        0  unknown  no
## 1272  2008-05-08      141        1    -1        0  unknown  no
## 1273  2008-05-08      255        1    -1        0  unknown  no
## 1274  2008-05-08     1120        2    -1        0  unknown yes
## 1275  2008-05-08      306        1    -1        0  unknown  no
## 1276  2008-05-08      249        1    -1        0  unknown  no
## 1277  2008-05-08      215        1    -1        0  unknown  no
## 1278  2008-05-08      143        1    -1        0  unknown  no
## 1279  2008-05-08      162        1    -1        0  unknown  no
## 1280  2008-05-08       81        1    -1        0  unknown  no
## 1281  2008-05-08       33        4    -1        0  unknown  no
## 1282  2008-05-08      204        1    -1        0  unknown  no
## 1283  2008-05-08      124        1    -1        0  unknown  no
## 1284  2008-05-08      784        1    -1        0  unknown  no
## 1285  2008-05-08      393        1    -1        0  unknown  no
## 1286  2008-05-08       87        2    -1        0  unknown  no
## 1287  2008-05-08      108        2    -1        0  unknown  no
## 1288  2008-05-08      207        1    -1        0  unknown  no
## 1289  2008-05-08      278        2    -1        0  unknown  no
## 1290  2008-05-08       74        1    -1        0  unknown  no
## 1291  2008-05-08      196        1    -1        0  unknown  no
## 1292  2008-05-08      149        1    -1        0  unknown  no
## 1293  2008-05-08      287        2    -1        0  unknown  no
## 1294  2008-05-08      229        1    -1        0  unknown  no
## 1295  2008-05-08      154        1    -1        0  unknown  no
## 1296  2008-05-08      357        1    -1        0  unknown  no
## 1297  2008-05-08      147        1    -1        0  unknown  no
## 1298  2008-05-08       93        1    -1        0  unknown  no
## 1299  2008-05-08      665        1    -1        0  unknown  no
## 1300  2008-05-08      131        1    -1        0  unknown  no
## 1301  2008-05-08      160        1    -1        0  unknown  no
## 1302  2008-05-08       74        1    -1        0  unknown  no
## 1303  2008-05-08       60        1    -1        0  unknown  no
## 1304  2008-05-08       82        1    -1        0  unknown  no
## 1305  2008-05-08      475        1    -1        0  unknown  no
## 1306  2008-05-08      111        1    -1        0  unknown  no
## 1307  2008-05-08      284        4    -1        0  unknown  no
## 1308  2008-05-08      140        1    -1        0  unknown  no
## 1309  2008-05-08      110        1    -1        0  unknown  no
## 1310  2008-05-08       64        1    -1        0  unknown  no
## 1311  2008-05-08      149        1    -1        0  unknown  no
## 1312  2008-05-08      256        2    -1        0  unknown  no
## 1313  2008-05-08      156        1    -1        0  unknown  no
## 1314  2008-05-08       63        3    -1        0  unknown  no
## 1315  2008-05-08      362        1    -1        0  unknown  no
## 1316  2008-05-08       32        3    -1        0  unknown  no
## 1317  2008-05-08      712        1    -1        0  unknown  no
## 1318  2008-05-08      102        2    -1        0  unknown  no
## 1319  2008-05-08      338        2    -1        0  unknown  no
## 1320  2008-05-08       69        2    -1        0  unknown  no
## 1321  2008-05-08      446        1    -1        0  unknown  no
## 1322  2008-05-08      249        2    -1        0  unknown  no
## 1323  2008-05-08      176        1    -1        0  unknown  no
## 1324  2008-05-08     1007        1    -1        0  unknown  no
## 1325  2008-05-08      266        1    -1        0  unknown  no
## 1326  2008-05-08      172        1    -1        0  unknown  no
## 1327  2008-05-08      323        1    -1        0  unknown  no
## 1328  2008-05-08      175        1    -1        0  unknown  no
## 1329  2008-05-08      459        1    -1        0  unknown  no
## 1330  2008-05-08      211        2    -1        0  unknown  no
## 1331  2008-05-08      237        1    -1        0  unknown  no
## 1332  2008-05-08       50        1    -1        0  unknown  no
## 1333  2008-05-08      500        1    -1        0  unknown  no
## 1334  2008-05-08      186        1    -1        0  unknown  no
## 1335  2008-05-08       96        1    -1        0  unknown  no
## 1336  2008-05-08       98        1    -1        0  unknown  no
## 1337  2008-05-08      364        4    -1        0  unknown  no
## 1338  2008-05-08      477        1    -1        0  unknown  no
## 1339  2008-05-08      319        1    -1        0  unknown  no
## 1340  2008-05-08      178        1    -1        0  unknown  no
## 1341  2008-05-08      513        1    -1        0  unknown yes
## 1342  2008-05-08      170        1    -1        0  unknown  no
## 1343  2008-05-08      139        1    -1        0  unknown  no
## 1344  2008-05-08       70        1    -1        0  unknown  no
## 1345  2008-05-08      110        1    -1        0  unknown  no
## 1346  2008-05-08      280        2    -1        0  unknown  no
## 1347  2008-05-08      667        1    -1        0  unknown  no
## 1348  2008-05-08       63        2    -1        0  unknown  no
## 1349  2008-05-08      159        4    -1        0  unknown  no
## 1350  2008-05-08      177        2    -1        0  unknown  no
## 1351  2008-05-08      108        3    -1        0  unknown  no
## 1352  2008-05-08      194        3    -1        0  unknown  no
## 1353  2008-05-08      366        2    -1        0  unknown  no
## 1354  2008-05-08      213        1    -1        0  unknown  no
## 1355  2008-05-08      141        1    -1        0  unknown  no
## 1356  2008-05-08      982        1    -1        0  unknown  no
## 1357  2008-05-08      168        2    -1        0  unknown  no
## 1358  2008-05-08      468        1    -1        0  unknown  no
## 1359  2008-05-08      180        1    -1        0  unknown  no
## 1360  2008-05-08      195        1    -1        0  unknown  no
## 1361  2008-05-08      352        3    -1        0  unknown  no
## 1362  2008-05-08       91        1    -1        0  unknown  no
## 1363  2008-05-08      288        1    -1        0  unknown  no
## 1364  2008-05-08       72        1    -1        0  unknown  no
## 1365  2008-05-08      218        2    -1        0  unknown  no
## 1366  2008-05-08      289        1    -1        0  unknown  no
## 1367  2008-05-08      384        1    -1        0  unknown  no
## 1368  2008-05-08      130        3    -1        0  unknown  no
## 1369  2008-05-08      226        1    -1        0  unknown  no
## 1370  2008-05-08      208        1    -1        0  unknown  no
## 1371  2008-05-08      442        2    -1        0  unknown yes
## 1372  2008-05-08      101        1    -1        0  unknown  no
## 1373  2008-05-08      756        1    -1        0  unknown yes
## 1374  2008-05-08      189        1    -1        0  unknown  no
## 1375  2008-05-08      108        1    -1        0  unknown  no
## 1376  2008-05-08      205        1    -1        0  unknown  no
## 1377  2008-05-08      238        1    -1        0  unknown  no
## 1378  2008-05-08      136        1    -1        0  unknown  no
## 1379  2008-05-08       14        1    -1        0  unknown  no
## 1380  2008-05-08      395        1    -1        0  unknown  no
## 1381  2008-05-08      161        1    -1        0  unknown  no
## 1382  2008-05-08      269        3    -1        0  unknown  no
## 1383  2008-05-08      491        1    -1        0  unknown  no
## 1384  2008-05-08       44        1    -1        0  unknown  no
## 1385  2008-05-08       26        1    -1        0  unknown  no
## 1386  2008-05-08       22        1    -1        0  unknown  no
## 1387  2008-05-08      161        8    -1        0  unknown  no
## 1388  2008-05-08      406        2    -1        0  unknown  no
## 1389  2008-05-08      422        4    -1        0  unknown  no
## 1390  2008-05-08      147        5    -1        0  unknown  no
## 1391  2008-05-08      219        3    -1        0  unknown  no
## 1392  2008-05-08      807        2    -1        0  unknown  no
## 1393  2008-05-08      347        2    -1        0  unknown  no
## 1394  2008-05-08      534        2    -1        0  unknown  no
## 1395  2008-05-08       58        2    -1        0  unknown  no
## 1396  2008-05-08      155        2    -1        0  unknown  no
## 1397  2008-05-08      152        2    -1        0  unknown  no
## 1398  2008-05-08      461        3    -1        0  unknown  no
## 1399  2008-05-08      389        2    -1        0  unknown  no
## 1400  2008-05-08      314        3    -1        0  unknown  no
## 1401  2008-05-08       28        3    -1        0  unknown  no
## 1402  2008-05-08      229        2    -1        0  unknown  no
## 1403  2008-05-08       30        2    -1        0  unknown  no
## 1404  2008-05-08      103        4    -1        0  unknown  no
## 1405  2008-05-08       32        2    -1        0  unknown  no
## 1406  2008-05-08      252        2    -1        0  unknown  no
## 1407  2008-05-08      369        2    -1        0  unknown  no
## 1408  2008-05-08      116        1    -1        0  unknown  no
## 1409  2008-05-08       20        2    -1        0  unknown  no
## 1410  2008-05-08       31        1    -1        0  unknown  no
## 1411  2008-05-08      190        1    -1        0  unknown  no
## 1412  2008-05-08      149        1    -1        0  unknown  no
## 1413  2008-05-08      210        1    -1        0  unknown  no
## 1414  2008-05-08      234        1    -1        0  unknown  no
## 1415  2008-05-08       63        1    -1        0  unknown  no
## 1416  2008-05-08       21        1    -1        0  unknown  no
## 1417  2008-05-08     2087        2    -1        0  unknown yes
## 1418  2008-05-08      102        1    -1        0  unknown  no
## 1419  2008-05-08      245        1    -1        0  unknown  no
## 1420  2008-05-08      190        1    -1        0  unknown  no
## 1421  2008-05-08      223        2    -1        0  unknown  no
## 1422  2008-05-08      650        2    -1        0  unknown  no
## 1423  2008-05-08       42        1    -1        0  unknown  no
## 1424  2008-05-08      206        2    -1        0  unknown  no
## 1425  2008-05-08       66        2    -1        0  unknown  no
## 1426  2008-05-08      173        2    -1        0  unknown  no
## 1427  2008-05-08      477        2    -1        0  unknown  no
## 1428  2008-05-08       77        1    -1        0  unknown  no
## 1429  2008-05-08      219        2    -1        0  unknown  no
## 1430  2008-05-08      376        2    -1        0  unknown  no
## 1431  2008-05-08      453        2    -1        0  unknown  no
## 1432  2008-05-08      151        2    -1        0  unknown  no
## 1433  2008-05-08      200        2    -1        0  unknown  no
## 1434  2008-05-08      298        5    -1        0  unknown  no
## 1435  2008-05-08      627        3    -1        0  unknown  no
## 1436  2008-05-08      133        1    -1        0  unknown  no
## 1437  2008-05-08      287        1    -1        0  unknown  no
## 1438  2008-05-08      242        1    -1        0  unknown  no
## 1439  2008-05-08      184        1    -1        0  unknown  no
## 1440  2008-05-08      119        2    -1        0  unknown  no
## 1441  2008-05-08      403        2    -1        0  unknown  no
## 1442  2008-05-08      626        6    -1        0  unknown  no
## 1443  2008-05-08       12        1    -1        0  unknown  no
## 1444  2008-05-08      266        1    -1        0  unknown  no
## 1445  2008-05-08       23        4    -1        0  unknown  no
## 1446  2008-05-08      154        2    -1        0  unknown  no
## 1447  2008-05-08       10        7    -1        0  unknown  no
## 1448  2008-05-08       66        2    -1        0  unknown  no
## 1449  2008-05-08      240        3    -1        0  unknown  no
## 1450  2008-05-08      224        2    -1        0  unknown  no
## 1451  2008-05-08      202        2    -1        0  unknown  no
## 1452  2008-05-08      144        3    -1        0  unknown  no
## 1453  2008-05-08      263        2    -1        0  unknown  no
## 1454  2008-05-08      543        3    -1        0  unknown  no
## 1455  2008-05-08      257        2    -1        0  unknown  no
## 1456  2008-05-08      237        2    -1        0  unknown  no
## 1457  2008-05-08       23        5    -1        0  unknown  no
## 1458  2008-05-08      209        3    -1        0  unknown  no
## 1459  2008-05-08       34        1    -1        0  unknown  no
## 1460  2008-05-08       72        1    -1        0  unknown  no
## 1461  2008-05-08      442        2    -1        0  unknown  no
## 1462  2008-05-08       45        2    -1        0  unknown  no
## 1463  2008-05-08     1120        2    -1        0  unknown yes
## 1464  2008-05-08      186        2    -1        0  unknown  no
## 1465  2008-05-08      318        2    -1        0  unknown  no
## 1466  2008-05-08      617        2    -1        0  unknown  no
## 1467  2008-05-08      226        1    -1        0  unknown  no
## 1468  2008-05-08      275        1    -1        0  unknown  no
## 1469  2008-05-08       81        2    -1        0  unknown  no
## 1470  2008-05-08       74        7    -1        0  unknown  no
## 1471  2008-05-08      285        1    -1        0  unknown  no
## 1472  2008-05-08      261        5    -1        0  unknown  no
## 1473  2008-05-08      297        1    -1        0  unknown  no
## 1474  2008-05-08       78        3    -1        0  unknown  no
## 1475  2008-05-08      183        3    -1        0  unknown  no
## 1476  2008-05-08       15        1    -1        0  unknown  no
## 1477  2008-05-08      352        2    -1        0  unknown  no
## 1478  2008-05-08      345        2    -1        0  unknown  no
## 1479  2008-05-08      230        4    -1        0  unknown  no
## 1480  2008-05-08      185        2    -1        0  unknown  no
## 1481  2008-05-08      296        1    -1        0  unknown  no
## 1482  2008-05-08      181        2    -1        0  unknown  no
## 1483  2008-05-08      133        2    -1        0  unknown  no
## 1484  2008-05-08      335        9    -1        0  unknown  no
## 1485  2008-05-08      139        1    -1        0  unknown  no
## 1486  2008-05-08        7        3    -1        0  unknown  no
## 1487  2008-05-08      163        2    -1        0  unknown  no
## 1488  2008-05-08      956        2    -1        0  unknown  no
## 1489  2008-05-08      166        2    -1        0  unknown  no
## 1490  2008-05-08       71        2    -1        0  unknown  no
## 1491  2008-05-08      191        2    -1        0  unknown  no
## 1492  2008-05-08      459        2    -1        0  unknown  no
## 1493  2008-05-08      292        2    -1        0  unknown  no
## 1494  2008-05-08      100        5    -1        0  unknown  no
## 1495  2008-05-08      257        3    -1        0  unknown  no
## 1496  2008-05-08      255        6    -1        0  unknown  no
## 1497  2008-05-08      233        2    -1        0  unknown  no
## 1498  2008-05-08      128        2    -1        0  unknown  no
## 1499  2008-05-08      246        2    -1        0  unknown  no
## 1500  2008-05-08       56        2    -1        0  unknown  no
## 1501  2008-05-08      210        2    -1        0  unknown  no
## 1502  2008-05-08       43        2    -1        0  unknown  no
## 1503  2008-05-08       21        9    -1        0  unknown  no
## 1504  2008-05-08       91        2    -1        0  unknown  no
## 1505  2008-05-08       67        2    -1        0  unknown  no
## 1506  2008-05-08      219        4    -1        0  unknown  no
## 1507  2008-05-08      110        2    -1        0  unknown  no
## 1508  2008-05-08      169        2    -1        0  unknown  no
## 1509  2008-05-08      248        3    -1        0  unknown  no
## 1510  2008-05-08      223        2    -1        0  unknown  no
## 1511  2008-05-08       92        3    -1        0  unknown  no
## 1512  2008-05-08       93        2    -1        0  unknown  no
## 1513  2008-05-08      205        4    -1        0  unknown  no
## 1514  2008-05-08      160        1    -1        0  unknown  no
## 1515  2008-05-08      105        2    -1        0  unknown  no
## 1516  2008-05-08      112        2    -1        0  unknown  no
## 1517  2008-05-08      383        3    -1        0  unknown  no
## 1518  2008-05-08      207        2    -1        0  unknown  no
## 1519  2008-05-08      193        2    -1        0  unknown  no
## 1520  2008-05-08       10        2    -1        0  unknown  no
## 1521  2008-05-08      985        2    -1        0  unknown yes
## 1522  2008-05-08      249        5    -1        0  unknown  no
## 1523  2008-05-08      122        2    -1        0  unknown  no
## 1524  2008-05-08      300        2    -1        0  unknown  no
## 1525  2008-05-08      672        3    -1        0  unknown  no
## 1526  2008-05-08      390        3    -1        0  unknown  no
## 1527  2008-05-08      116        2    -1        0  unknown  no
## 1528  2008-05-08      481        2    -1        0  unknown  no
## 1529  2008-05-08       21        3    -1        0  unknown  no
## 1530  2008-05-08      192        2    -1        0  unknown  no
## 1531  2008-05-08        6        2    -1        0  unknown  no
## 1532  2008-05-08        8        2    -1        0  unknown  no
## 1533  2008-05-08      369        2    -1        0  unknown  no
## 1534  2008-05-08      393        2    -1        0  unknown  no
## 1535  2008-05-08      246        3    -1        0  unknown  no
## 1536  2008-05-08      330        3    -1        0  unknown  no
## 1537  2008-05-08      380        2    -1        0  unknown  no
## 1538  2008-05-08       91        3    -1        0  unknown  no
## 1539  2008-05-08       84        2    -1        0  unknown  no
## 1540  2008-05-08      277        3    -1        0  unknown  no
## 1541  2008-05-08      399        4    -1        0  unknown  no
## 1542  2008-05-08       89        4    -1        0  unknown  no
## 1543  2008-05-08      297        2    -1        0  unknown  no
## 1544  2008-05-08      176        2    -1        0  unknown  no
## 1545  2008-05-08       75        4    -1        0  unknown  no
## 1546  2008-05-08      111        3    -1        0  unknown  no
## 1547  2008-05-08      170        2    -1        0  unknown  no
## 1548  2008-05-08      238        8    -1        0  unknown  no
## 1549  2008-05-08      137        2    -1        0  unknown  no
## 1550  2008-05-08      141        2    -1        0  unknown  no
## 1551  2008-05-08       49        4    -1        0  unknown  no
## 1552  2008-05-08       89        8    -1        0  unknown  no
## 1553  2008-05-08      341        2    -1        0  unknown  no
## 1554  2008-05-08      461        3    -1        0  unknown  no
## 1555  2008-05-08      515        3    -1        0  unknown  no
## 1556  2008-05-08      123        2    -1        0  unknown  no
## 1557  2008-05-08      179        5    -1        0  unknown  no
## 1558  2008-05-08      102        4    -1        0  unknown  no
## 1559  2008-05-08      272        4    -1        0  unknown  no
## 1560  2008-05-08       17        3    -1        0  unknown  no
## 1561  2008-05-08       40        2    -1        0  unknown  no
## 1562  2008-05-08      209        3    -1        0  unknown  no
## 1563  2008-05-08       89        5    -1        0  unknown  no
## 1564  2008-05-08     1187        2    -1        0  unknown  no
## 1565  2008-05-08      123        2    -1        0  unknown  no
## 1566  2008-05-08      104        3    -1        0  unknown  no
## 1567  2008-05-08      200        2    -1        0  unknown  no
## 1568  2008-05-08      117        3    -1        0  unknown  no
## 1569  2008-05-08       37        3    -1        0  unknown  no
## 1570  2008-05-08       51        3    -1        0  unknown  no
## 1571  2008-05-08      145        4    -1        0  unknown  no
## 1572  2008-05-08      466        2    -1        0  unknown  no
## 1573  2008-05-08      303        3    -1        0  unknown  no
## 1574  2008-05-08      101        2    -1        0  unknown  no
## 1575  2008-05-08      283        3    -1        0  unknown  no
## 1576  2008-05-08      826        3    -1        0  unknown  no
## 1577  2008-05-08      185        4    -1        0  unknown  no
## 1578  2008-05-08      598        3    -1        0  unknown  no
## 1579  2008-05-08      120        5    -1        0  unknown  no
## 1580  2008-05-08      185        7    -1        0  unknown  no
## 1581  2008-05-08      159        3    -1        0  unknown  no
## 1582  2008-05-08      220        2    -1        0  unknown  no
## 1583  2008-05-08      192        4    -1        0  unknown  no
## 1584  2008-05-08      423        2    -1        0  unknown  no
## 1585  2008-05-08      337        4    -1        0  unknown  no
## 1586  2008-05-08      306        2    -1        0  unknown  no
## 1587  2008-05-08       99        3    -1        0  unknown  no
## 1588  2008-05-08       27        3    -1        0  unknown  no
## 1589  2008-05-08      201        2    -1        0  unknown  no
## 1590  2008-05-08      166        3    -1        0  unknown  no
## 1591  2008-05-08      182        1    -1        0  unknown  no
## 1592  2008-05-08      193        1    -1        0  unknown  no
## 1593  2008-05-08      271        5    -1        0  unknown  no
## 1594  2008-05-08      103        3    -1        0  unknown  no
## 1595  2008-05-08      287        4    -1        0  unknown  no
## 1596  2008-05-08      235        4    -1        0  unknown  no
## 1597  2008-05-08      732        2    -1        0  unknown  no
## 1598  2008-05-08      136        2    -1        0  unknown  no
## 1599  2008-05-08      126        3    -1        0  unknown  no
## 1600  2008-05-08      172        4    -1        0  unknown  no
## 1601  2008-05-08       43        2    -1        0  unknown  no
## 1602  2008-05-08      191        2    -1        0  unknown  no
## 1603  2008-05-08      117        2    -1        0  unknown  no
## 1604  2008-05-08       64        1    -1        0  unknown  no
## 1605  2008-05-08      260        5    -1        0  unknown  no
## 1606  2008-05-08      149        1    -1        0  unknown  no
## 1607  2008-05-08      207        3    -1        0  unknown  no
## 1608  2008-05-08      231        4    -1        0  unknown  no
## 1609  2008-05-08      128        3    -1        0  unknown  no
## 1610  2008-05-09      162        5    -1        0  unknown  no
## 1611  2008-05-09      180        2    -1        0  unknown  no
## 1612  2008-05-09      144        2    -1        0  unknown  no
## 1613  2008-05-09      260        3    -1        0  unknown  no
## 1614  2008-05-09      203        4    -1        0  unknown  no
## 1615  2008-05-09       85        2    -1        0  unknown  no
## 1616  2008-05-09      211        2    -1        0  unknown  no
## 1617  2008-05-09       94        2    -1        0  unknown  no
## 1618  2008-05-09      122        4    -1        0  unknown  no
## 1619  2008-05-09      175        5    -1        0  unknown  no
## 1620  2008-05-09      292        2    -1        0  unknown  no
## 1621  2008-05-09      132        5    -1        0  unknown  no
## 1622  2008-05-09      130        2    -1        0  unknown  no
## 1623  2008-05-09      208        2    -1        0  unknown  no
## 1624  2008-05-09      105        1    -1        0  unknown  no
## 1625  2008-05-09      205        1    -1        0  unknown  no
## 1626  2008-05-09      112        1    -1        0  unknown  no
## 1627  2008-05-09      117        9    -1        0  unknown  no
## 1628  2008-05-09      218        1    -1        0  unknown  no
## 1629  2008-05-09       62        1    -1        0  unknown  no
## 1630  2008-05-09       97        1    -1        0  unknown  no
## 1631  2008-05-09      101        3    -1        0  unknown  no
## 1632  2008-05-09      286        1    -1        0  unknown  no
## 1633  2008-05-09      241        1    -1        0  unknown  no
## 1634  2008-05-09      252        4    -1        0  unknown  no
## 1635  2008-05-09      283        1    -1        0  unknown  no
## 1636  2008-05-09      131        1    -1        0  unknown  no
## 1637  2008-05-09      380        1    -1        0  unknown  no
## 1638  2008-05-09      584        1    -1        0  unknown  no
## 1639  2008-05-09      371        1    -1        0  unknown  no
## 1640  2008-05-09      448        1    -1        0  unknown  no
## 1641  2008-05-09      274        1    -1        0  unknown  no
## 1642  2008-05-09      116        2    -1        0  unknown  no
## 1643  2008-05-09      357        1    -1        0  unknown  no
## 1644  2008-05-09      215        1    -1        0  unknown  no
## 1645  2008-05-09      131        1    -1        0  unknown  no
## 1646  2008-05-09       61        1    -1        0  unknown  no
## 1647  2008-05-09      617        4    -1        0  unknown yes
## 1648  2008-05-09      483        3    -1        0  unknown yes
## 1649  2008-05-09      847        1    -1        0  unknown  no
## 1650  2008-05-09      319        1    -1        0  unknown  no
## 1651  2008-05-09       57        2    -1        0  unknown  no
## 1652  2008-05-09      306        1    -1        0  unknown  no
## 1653  2008-05-09      147        1    -1        0  unknown  no
## 1654  2008-05-09      244        1    -1        0  unknown  no
## 1655  2008-05-09      128        1    -1        0  unknown  no
## 1656  2008-05-09      100        1    -1        0  unknown  no
## 1657  2008-05-09       59        1    -1        0  unknown  no
## 1658  2008-05-09       24        1    -1        0  unknown  no
## 1659  2008-05-09       85        2    -1        0  unknown  no
## 1660  2008-05-09       70        1    -1        0  unknown  no
## 1661  2008-05-09       21        1    -1        0  unknown  no
## 1662  2008-05-09      167        1    -1        0  unknown  no
## 1663  2008-05-09      659        2    -1        0  unknown  no
## 1664  2008-05-09      327        2    -1        0  unknown  no
## 1665  2008-05-09      296        3    -1        0  unknown  no
## 1666  2008-05-09      307        1    -1        0  unknown  no
## 1667  2008-05-09      120        1    -1        0  unknown  no
## 1668  2008-05-09      390        2    -1        0  unknown  no
## 1669  2008-05-09       83        2    -1        0  unknown  no
## 1670  2008-05-09      250        1    -1        0  unknown  no
## 1671  2008-05-09      143        1    -1        0  unknown  no
## 1672  2008-05-09      772        1    -1        0  unknown yes
## 1673  2008-05-09      198        1    -1        0  unknown  no
## 1674  2008-05-09       21        3    -1        0  unknown  no
## 1675  2008-05-09      929        3    -1        0  unknown yes
## 1676  2008-05-09      254        1    -1        0  unknown  no
## 1677  2008-05-09      166        1    -1        0  unknown  no
## 1678  2008-05-09       93        1    -1        0  unknown  no
## 1679  2008-05-09      134        2    -1        0  unknown  no
## 1680  2008-05-09      375        2    -1        0  unknown  no
## 1681  2008-05-09      352        1    -1        0  unknown  no
## 1682  2008-05-09      217        2    -1        0  unknown  no
## 1683  2008-05-09       45        1    -1        0  unknown  no
## 1684  2008-05-09       93        1    -1        0  unknown  no
## 1685  2008-05-09      165        1    -1        0  unknown  no
## 1686  2008-05-09      266        1    -1        0  unknown  no
## 1687  2008-05-09      237        1    -1        0  unknown  no
## 1688  2008-05-09      164        1    -1        0  unknown  no
## 1689  2008-05-09      538        1    -1        0  unknown yes
## 1690  2008-05-09       72        2    -1        0  unknown  no
## 1691  2008-05-09      171        1    -1        0  unknown  no
## 1692  2008-05-09      710        1    -1        0  unknown yes
## 1693  2008-05-09      131        3    -1        0  unknown  no
## 1694  2008-05-09      514        1    -1        0  unknown  no
## 1695  2008-05-09      127        1    -1        0  unknown  no
## 1696  2008-05-09      198        1    -1        0  unknown  no
## 1697  2008-05-09      239        1    -1        0  unknown  no
## 1698  2008-05-09      117        1    -1        0  unknown  no
## 1699  2008-05-09      705        1    -1        0  unknown  no
## 1700  2008-05-09      155        1    -1        0  unknown  no
## 1701  2008-05-09       18        1    -1        0  unknown  no
## 1702  2008-05-09      386        1    -1        0  unknown  no
## 1703  2008-05-09      138        1    -1        0  unknown  no
## 1704  2008-05-09      341        1    -1        0  unknown  no
## 1705  2008-05-09      339        2    -1        0  unknown  no
## 1706  2008-05-09      232        1    -1        0  unknown  no
## 1707  2008-05-09      208        1    -1        0  unknown  no
## 1708  2008-05-09      124        2    -1        0  unknown  no
## 1709  2008-05-09       44        1    -1        0  unknown  no
## 1710  2008-05-09       75        1    -1        0  unknown  no
## 1711  2008-05-09      485        1    -1        0  unknown  no
## 1712  2008-05-09      576        1    -1        0  unknown  no
## 1713  2008-05-09      280        1    -1        0  unknown  no
## 1714  2008-05-09      480        2    -1        0  unknown  no
## 1715  2008-05-09       86        2    -1        0  unknown  no
## 1716  2008-05-09      121        4    -1        0  unknown  no
## 1717  2008-05-09       93        2    -1        0  unknown  no
## 1718  2008-05-09      211        3    -1        0  unknown  no
## 1719  2008-05-09      238        2    -1        0  unknown  no
## 1720  2008-05-09      399        3    -1        0  unknown  no
## 1721  2008-05-09       93        2    -1        0  unknown  no
## 1722  2008-05-09      144        3    -1        0  unknown  no
## 1723  2008-05-09       45        2    -1        0  unknown  no
## 1724  2008-05-09       98        1    -1        0  unknown  no
## 1725  2008-05-09      128        1    -1        0  unknown  no
## 1726  2008-05-09      106        1    -1        0  unknown  no
## 1727  2008-05-09      121        1    -1        0  unknown  no
## 1728  2008-05-09      123        1    -1        0  unknown  no
## 1729  2008-05-09       92        2    -1        0  unknown  no
## 1730  2008-05-09      278        1    -1        0  unknown  no
## 1731  2008-05-09      219        1    -1        0  unknown  no
## 1732  2008-05-09     2462        1    -1        0  unknown  no
## 1733  2008-05-09      249        3    -1        0  unknown  no
## 1734  2008-05-09      210        1    -1        0  unknown  no
## 1735  2008-05-09      484        1    -1        0  unknown  no
## 1736  2008-05-09      187        1    -1        0  unknown  no
## 1737  2008-05-09      172        1    -1        0  unknown  no
## 1738  2008-05-09       79        4    -1        0  unknown  no
## 1739  2008-05-09      207        1    -1        0  unknown  no
## 1740  2008-05-09      136        2    -1        0  unknown  no
## 1741  2008-05-09      117        2    -1        0  unknown  no
## 1742  2008-05-09      393        1    -1        0  unknown  no
## 1743  2008-05-09      107        1    -1        0  unknown  no
## 1744  2008-05-09       25        1    -1        0  unknown  no
## 1745  2008-05-09      132        3    -1        0  unknown  no
## 1746  2008-05-09      136        1    -1        0  unknown  no
## 1747  2008-05-09      384        2    -1        0  unknown  no
## 1748  2008-05-09       38        1    -1        0  unknown  no
## 1749  2008-05-09      164        1    -1        0  unknown  no
## 1750  2008-05-09      825        1    -1        0  unknown  no
## 1751  2008-05-09      331        1    -1        0  unknown  no
## 1752  2008-05-09      479        2    -1        0  unknown  no
## 1753  2008-05-09      229        2    -1        0  unknown  no
## 1754  2008-05-09      258        2    -1        0  unknown  no
## 1755  2008-05-09      490        1    -1        0  unknown  no
## 1756  2008-05-09      308        1    -1        0  unknown  no
## 1757  2008-05-09      137        1    -1        0  unknown  no
## 1758  2008-05-09      545        2    -1        0  unknown  no
## 1759  2008-05-09      109        1    -1        0  unknown  no
## 1760  2008-05-09      168        2    -1        0  unknown  no
## 1761  2008-05-09      257        6    -1        0  unknown  no
## 1762  2008-05-09      213        2    -1        0  unknown  no
## 1763  2008-05-09      115        1    -1        0  unknown  no
## 1764  2008-05-09      646        1    -1        0  unknown  no
## 1765  2008-05-09      106        1    -1        0  unknown  no
## 1766  2008-05-09       95        2    -1        0  unknown  no
## 1767  2008-05-09      205        1    -1        0  unknown  no
## 1768  2008-05-09      653        1    -1        0  unknown yes
## 1769  2008-05-09      122        1    -1        0  unknown  no
## 1770  2008-05-09      377        1    -1        0  unknown  no
## 1771  2008-05-09      322        1    -1        0  unknown  no
## 1772  2008-05-09      208        3    -1        0  unknown  no
## 1773  2008-05-09       46        2    -1        0  unknown  no
## 1774  2008-05-09      211        2    -1        0  unknown  no
## 1775  2008-05-09      156        2    -1        0  unknown  no
## 1776  2008-05-09      178        2    -1        0  unknown  no
## 1777  2008-05-09      133        2    -1        0  unknown  no
## 1778  2008-05-09      206        2    -1        0  unknown  no
## 1779  2008-05-09      544        1    -1        0  unknown  no
## 1780  2008-05-09      143        1    -1        0  unknown  no
## 1781  2008-05-09      471        2    -1        0  unknown  no
## 1782  2008-05-09      200        3    -1        0  unknown  no
## 1783  2008-05-09      324        2    -1        0  unknown  no
## 1784  2008-05-09       71        1    -1        0  unknown  no
## 1785  2008-05-09      164        5    -1        0  unknown  no
## 1786  2008-05-09      137        3    -1        0  unknown  no
## 1787  2008-05-09       91        2    -1        0  unknown  no
## 1788  2008-05-09      280        1    -1        0  unknown  no
## 1789  2008-05-09      230        2    -1        0  unknown  no
## 1790  2008-05-09       63        1    -1        0  unknown  no
## 1791  2008-05-09      135        1    -1        0  unknown  no
## 1792  2008-05-09      261        1    -1        0  unknown  no
## 1793  2008-05-09      215        2    -1        0  unknown  no
## 1794  2008-05-09      200        4    -1        0  unknown  no
## 1795  2008-05-09      391        2    -1        0  unknown  no
## 1796  2008-05-09     1028        2    -1        0  unknown yes
## 1797  2008-05-09      107        3    -1        0  unknown  no
## 1798  2008-05-09      108        2    -1        0  unknown  no
## 1799  2008-05-09      145        2    -1        0  unknown  no
## 1800  2008-05-09      142        2    -1        0  unknown  no
## 1801  2008-05-09      106        1    -1        0  unknown  no
## 1802  2008-05-09      134        1    -1        0  unknown  no
## 1803  2008-05-09      190        1    -1        0  unknown  no
## 1804  2008-05-09      241        1    -1        0  unknown  no
## 1805  2008-05-09      180        1    -1        0  unknown  no
## 1806  2008-05-09      237        1    -1        0  unknown  no
## 1807  2008-05-09      654        1    -1        0  unknown yes
## 1808  2008-05-09      189        1    -1        0  unknown  no
## 1809  2008-05-09       70        1    -1        0  unknown  no
## 1810  2008-05-09       62        1    -1        0  unknown  no
## 1811  2008-05-09     1087        2    -1        0  unknown  no
## 1812  2008-05-09      323        1    -1        0  unknown  no
## 1813  2008-05-09      111        2    -1        0  unknown  no
## 1814  2008-05-09      197        4    -1        0  unknown  no
## 1815  2008-05-09      224        3    -1        0  unknown  no
## 1816  2008-05-09      557        1    -1        0  unknown  no
## 1817  2008-05-09      150        2    -1        0  unknown  no
## 1818  2008-05-09      388        2    -1        0  unknown  no
## 1819  2008-05-09       89        1    -1        0  unknown  no
## 1820  2008-05-09       57        2    -1        0  unknown  no
## 1821  2008-05-09      209        3    -1        0  unknown  no
## 1822  2008-05-09      188        1    -1        0  unknown  no
## 1823  2008-05-09      342        1    -1        0  unknown  no
## 1824  2008-05-09       84        1    -1        0  unknown  no
## 1825  2008-05-09       97        1    -1        0  unknown  no
## 1826  2008-05-09      530        2    -1        0  unknown  no
## 1827  2008-05-09      365        1    -1        0  unknown  no
## 1828  2008-05-09      285        1    -1        0  unknown  no
## 1829  2008-05-09      352        1    -1        0  unknown  no
## 1830  2008-05-09      316        3    -1        0  unknown  no
## 1831  2008-05-09      126        2    -1        0  unknown  no
## 1832  2008-05-09       76        2    -1        0  unknown  no
## 1833  2008-05-09     1692        2    -1        0  unknown yes
## 1834  2008-05-09       24        1    -1        0  unknown  no
## 1835  2008-05-09      253        1    -1        0  unknown  no
## 1836  2008-05-09       73        1    -1        0  unknown  no
## 1837  2008-05-09      622        1    -1        0  unknown  no
## 1838  2008-05-09      133        1    -1        0  unknown  no
## 1839  2008-05-09      178        1    -1        0  unknown  no
## 1840  2008-05-09      404        2    -1        0  unknown  no
## 1841  2008-05-09      275        1    -1        0  unknown  no
## 1842  2008-05-09      109        1    -1        0  unknown  no
## 1843  2008-05-09      134        1    -1        0  unknown  no
## 1844  2008-05-09      407        2    -1        0  unknown  no
## 1845  2008-05-09      225        1    -1        0  unknown  no
## 1846  2008-05-09       86        2    -1        0  unknown  no
## 1847  2008-05-09       20        1    -1        0  unknown  no
## 1848  2008-05-09      247        1    -1        0  unknown  no
## 1849  2008-05-09      129        3    -1        0  unknown  no
## 1850  2008-05-09      324        1    -1        0  unknown  no
## 1851  2008-05-09     2016        2    -1        0  unknown yes
## 1852  2008-05-09     1054        2    -1        0  unknown  no
## 1853  2008-05-09      256        5    -1        0  unknown  no
## 1854  2008-05-09      163        2    -1        0  unknown  no
## 1855  2008-05-09      251        2    -1        0  unknown  no
## 1856  2008-05-09      113        4    -1        0  unknown  no
## 1857  2008-05-09      193        2    -1        0  unknown  no
## 1858  2008-05-09      125        3    -1        0  unknown  no
## 1859  2008-05-09      344        2    -1        0  unknown  no
## 1860  2008-05-09      282        2    -1        0  unknown  no
## 1861  2008-05-09     1170        1    -1        0  unknown  no
## 1862  2008-05-09      408        2    -1        0  unknown  no
## 1863  2008-05-09      128        2    -1        0  unknown  no
## 1864  2008-05-09      665        2    -1        0  unknown yes
## 1865  2008-05-09       67        3    -1        0  unknown  no
## 1866  2008-05-09      167        4    -1        0  unknown  no
## 1867  2008-05-09      395        1    -1        0  unknown  no
## 1868  2008-05-09      137        2    -1        0  unknown  no
## 1869  2008-05-09      118        1    -1        0  unknown  no
## 1870  2008-05-09      231        2    -1        0  unknown  no
## 1871  2008-05-09      128        1    -1        0  unknown  no
## 1872  2008-05-09      174        1    -1        0  unknown  no
## 1873  2008-05-09      195        1    -1        0  unknown  no
## 1874  2008-05-09      412        1    -1        0  unknown  no
## 1875  2008-05-09      127        1    -1        0  unknown  no
## 1876  2008-05-09       13        1    -1        0  unknown  no
## 1877  2008-05-09       61        1    -1        0  unknown  no
## 1878  2008-05-09      286        5    -1        0  unknown  no
## 1879  2008-05-09       76        1    -1        0  unknown  no
## 1880  2008-05-09       53        4    -1        0  unknown  no
## 1881  2008-05-09      274        2    -1        0  unknown  no
## 1882  2008-05-09      409        3    -1        0  unknown  no
## 1883  2008-05-09      232        1    -1        0  unknown  no
## 1884  2008-05-09      325        1    -1        0  unknown  no
## 1885  2008-05-09      144        2    -1        0  unknown  no
## 1886  2008-05-09     1713        1    -1        0  unknown  no
## 1887  2008-05-09      241        2    -1        0  unknown  no
## 1888  2008-05-09      103        2    -1        0  unknown  no
## 1889  2008-05-09      338        3    -1        0  unknown  no
## 1890  2008-05-09      182        1    -1        0  unknown  no
## 1891  2008-05-09      346        3    -1        0  unknown  no
## 1892  2008-05-09      204        2    -1        0  unknown  no
## 1893  2008-05-09      296        2    -1        0  unknown  no
## 1894  2008-05-09      551        2    -1        0  unknown  no
## 1895  2008-05-09      663        3    -1        0  unknown  no
## 1896  2008-05-09      338        4    -1        0  unknown  no
## 1897  2008-05-09      153        1    -1        0  unknown  no
## 1898  2008-05-09      188        2    -1        0  unknown  no
## 1899  2008-05-09      305        2    -1        0  unknown  no
## 1900  2008-05-09     1080        5    -1        0  unknown  no
## 1901  2008-05-09     1461        2    -1        0  unknown  no
## 1902  2008-05-09      116        1    -1        0  unknown  no
## 1903  2008-05-09      129        2    -1        0  unknown  no
## 1904  2008-05-09       98        3    -1        0  unknown  no
## 1905  2008-05-09      262        1    -1        0  unknown  no
## 1906  2008-05-09      147        7    -1        0  unknown  no
## 1907  2008-05-09      150        1    -1        0  unknown  no
## 1908  2008-05-09      282        2    -1        0  unknown  no
## 1909  2008-05-09      332        2    -1        0  unknown  no
## 1910  2008-05-09       88        4    -1        0  unknown  no
## 1911  2008-05-09       94        1    -1        0  unknown  no
## 1912  2008-05-09      455        1    -1        0  unknown  no
## 1913  2008-05-09       49        1    -1        0  unknown  no
## 1914  2008-05-09      181        1    -1        0  unknown  no
## 1915  2008-05-09      345        9    -1        0  unknown  no
## 1916  2008-05-09      154        3    -1        0  unknown  no
## 1917  2008-05-09      294        2    -1        0  unknown  no
## 1918  2008-05-09      750        7    -1        0  unknown  no
## 1919  2008-05-09      202        2    -1        0  unknown  no
## 1920  2008-05-09       81        6    -1        0  unknown  no
## 1921  2008-05-09      214        2    -1        0  unknown  no
## 1922  2008-05-09      128        1    -1        0  unknown  no
## 1923  2008-05-09       70        1    -1        0  unknown  no
## 1924  2008-05-09      106        1    -1        0  unknown  no
## 1925  2008-05-09      279        1    -1        0  unknown  no
## 1926  2008-05-09      400        2    -1        0  unknown  no
## 1927  2008-05-09      231        2    -1        0  unknown  no
## 1928  2008-05-09      175        2    -1        0  unknown  no
## 1929  2008-05-09      179        2    -1        0  unknown  no
## 1930  2008-05-09      107        4    -1        0  unknown  no
## 1931  2008-05-09       94        3    -1        0  unknown  no
## 1932  2008-05-09      142        2    -1        0  unknown  no
## 1933  2008-05-09      119        2    -1        0  unknown  no
## 1934  2008-05-09      180        3    -1        0  unknown  no
## 1935  2008-05-09      136        2    -1        0  unknown  no
## 1936  2008-05-09       44        3    -1        0  unknown  no
## 1937  2008-05-09      229        5    -1        0  unknown  no
## 1938  2008-05-09      184        2    -1        0  unknown  no
## 1939  2008-05-09       73        4    -1        0  unknown  no
## 1940  2008-05-09      330        4    -1        0  unknown  no
## 1941  2008-05-09      126        2    -1        0  unknown  no
## 1942  2008-05-09       83        4    -1        0  unknown  no
## 1943  2008-05-09       25        6    -1        0  unknown  no
## 1944  2008-05-09       26        2    -1        0  unknown  no
## 1945  2008-05-09      169        2    -1        0  unknown  no
## 1946  2008-05-09      179        2    -1        0  unknown  no
## 1947  2008-05-09      280        1    -1        0  unknown  no
## 1948  2008-05-09       61        4    -1        0  unknown  no
## 1949  2008-05-09      124        2    -1        0  unknown  no
## 1950  2008-05-09       89        2    -1        0  unknown  no
## 1951  2008-05-09      210        3    -1        0  unknown  no
## 1952  2008-05-09      393        2    -1        0  unknown  no
## 1953  2008-05-09     1178        4    -1        0  unknown  no
## 1954  2008-05-09      161        2    -1        0  unknown  no
## 1955  2008-05-09      515        4    -1        0  unknown  no
## 1956  2008-05-09      177        2    -1        0  unknown  no
## 1957  2008-05-09      178        2    -1        0  unknown  no
## 1958  2008-05-09      185        2    -1        0  unknown  no
## 1959  2008-05-09      218        2    -1        0  unknown  no
## 1960  2008-05-09      191        2    -1        0  unknown  no
## 1961  2008-05-09      245        4    -1        0  unknown  no
## 1962  2008-05-09      255        2    -1        0  unknown  no
## 1963  2008-05-09      488        2    -1        0  unknown  no
## 1964  2008-05-09      211        2    -1        0  unknown  no
## 1965  2008-05-09      226        2    -1        0  unknown  no
## 1966  2008-05-09      179        2    -1        0  unknown  no
## 1967  2008-05-09      460        2    -1        0  unknown  no
## 1968  2008-05-09      432        2    -1        0  unknown  no
## 1969  2008-05-09      176        2    -1        0  unknown  no
## 1970  2008-05-09      162        2    -1        0  unknown  no
## 1971  2008-05-09      192        2    -1        0  unknown  no
## 1972  2008-05-09      237        3    -1        0  unknown  no
## 1973  2008-05-09      134        3    -1        0  unknown  no
## 1974  2008-05-09       44        2    -1        0  unknown  no
## 1975  2008-05-09       47        5    -1        0  unknown  no
## 1976  2008-05-09      752        3    -1        0  unknown  no
## 1977  2008-05-09      116        3    -1        0  unknown  no
## 1978  2008-05-09      182        3    -1        0  unknown  no
## 1979  2008-05-09      122        2    -1        0  unknown  no
## 1980  2008-05-09       51        3    -1        0  unknown  no
## 1981  2008-05-09      260        4    -1        0  unknown  no
## 1982  2008-05-09      214        2    -1        0  unknown  no
## 1983  2008-05-09      407        4    -1        0  unknown  no
## 1984  2008-05-09      389        2    -1        0  unknown  no
## 1985  2008-05-09       31        3    -1        0  unknown  no
## 1986  2008-05-09      115        2    -1        0  unknown  no
## 1987  2008-05-09      878        3    -1        0  unknown  no
## 1988  2008-05-09      277        3    -1        0  unknown  no
## 1989  2008-05-09      117        2    -1        0  unknown  no
## 1990  2008-05-09      262        2    -1        0  unknown  no
## 1991  2008-05-09      244        4    -1        0  unknown  no
## 1992  2008-05-09      119        2    -1        0  unknown  no
## 1993  2008-05-09      162        2    -1        0  unknown  no
## 1994  2008-05-09      185        2    -1        0  unknown  no
## 1995  2008-05-09      317        2    -1        0  unknown  no
## 1996  2008-05-09      214        3    -1        0  unknown  no
## 1997  2008-05-09       71        3    -1        0  unknown  no
## 1998  2008-05-09       43        2    -1        0  unknown  no
## 1999  2008-05-09      298        2    -1        0  unknown  no
## 2000  2008-05-09      167        1    -1        0  unknown  no
## 2001  2008-05-09       86        4    -1        0  unknown  no
## 2002  2008-05-09      255        2    -1        0  unknown  no
## 2003  2008-05-09       83        3    -1        0  unknown  no
## 2004  2008-05-09      257        1    -1        0  unknown  no
## 2005  2008-05-09      194        3    -1        0  unknown  no
## 2006  2008-05-09      268        3    -1        0  unknown  no
## 2007  2008-05-09      176        2    -1        0  unknown  no
## 2008  2008-05-09       97        1    -1        0  unknown  no
## 2009  2008-05-09      263        5    -1        0  unknown  no
## 2010  2008-05-09      338        4    -1        0  unknown  no
## 2011  2008-05-09      180        2    -1        0  unknown  no
## 2012  2008-05-09      322        5    -1        0  unknown  no
## 2013  2008-05-09       64        4    -1        0  unknown  no
## 2014  2008-05-09       71        4    -1        0  unknown  no
## 2015  2008-05-09      166        3    -1        0  unknown  no
## 2016  2008-05-09      210        3    -1        0  unknown  no
## 2017  2008-05-09       77        2    -1        0  unknown  no
## 2018  2008-05-09      328        7    -1        0  unknown  no
## 2019  2008-05-09      164        8    -1        0  unknown  no
## 2020  2008-05-09      154        2    -1        0  unknown  no
## 2021  2008-05-09       84        4    -1        0  unknown  no
## 2022  2008-05-09      153        4    -1        0  unknown  no
## 2023  2008-05-09      155        3    -1        0  unknown  no
## 2024  2008-05-09      111        2    -1        0  unknown  no
## 2025  2008-05-09       91        3    -1        0  unknown  no
## 2026  2008-05-09      257        3    -1        0  unknown  no
## 2027  2008-05-09      213        4    -1        0  unknown  no
## 2028  2008-05-09      173        2    -1        0  unknown  no
## 2029  2008-05-09      315        4    -1        0  unknown  no
## 2030  2008-05-09      190        3    -1        0  unknown  no
## 2031  2008-05-09      102        3    -1        0  unknown  no
## 2032  2008-05-09       35        3    -1        0  unknown  no
## 2033  2008-05-09       83        3    -1        0  unknown  no
## 2034  2008-05-09      834        9    -1        0  unknown  no
## 2035  2008-05-09      244        5    -1        0  unknown  no
## 2036  2008-05-09      143        3    -1        0  unknown  no
## 2037  2008-05-09     1534        2    -1        0  unknown  no
## 2038  2008-05-09      291        4    -1        0  unknown  no
## 2039  2008-05-12      163        2    -1        0  unknown  no
## 2040  2008-05-12      149        6    -1        0  unknown  no
## 2041  2008-05-12       33        4    -1        0  unknown  no
## 2042  2008-05-12      144        6    -1        0  unknown  no
## 2043  2008-05-12       40        3    -1        0  unknown  no
## 2044  2008-05-12       79        6    -1        0  unknown  no
## 2045  2008-05-12      112        2    -1        0  unknown  no
## 2046  2008-05-12      147        5    -1        0  unknown  no
## 2047  2008-05-12      836        4    -1        0  unknown  no
## 2048  2008-05-12      290        5    -1        0  unknown  no
## 2049  2008-05-12      148        2    -1        0  unknown  no
## 2050  2008-05-12      289        5    -1        0  unknown  no
## 2051  2008-05-12      345        2    -1        0  unknown  no
## 2052  2008-05-12     1002        5    -1        0  unknown  no
## 2053  2008-05-12      181        4    -1        0  unknown  no
## 2054  2008-05-12      460        5    -1        0  unknown yes
## 2055  2008-05-12      129        2    -1        0  unknown  no
## 2056  2008-05-12       76        2    -1        0  unknown  no
## 2057  2008-05-12      111        2    -1        0  unknown  no
## 2058  2008-05-12      104        2    -1        0  unknown  no
## 2059  2008-05-12      221        2    -1        0  unknown  no
## 2060  2008-05-12      150        7    -1        0  unknown  no
## 2061  2008-05-12      399        3    -1        0  unknown  no
## 2062  2008-05-12      115        4    -1        0  unknown  no
## 2063  2008-05-12      149        5    -1        0  unknown  no
## 2064  2008-05-12       92        4    -1        0  unknown  no
## 2065  2008-05-12      111        2    -1        0  unknown  no
## 2066  2008-05-12      128        2    -1        0  unknown  no
## 2067  2008-05-12      192        2    -1        0  unknown  no
## 2068  2008-05-12       88        5    -1        0  unknown  no
## 2069  2008-05-12      592        2    -1        0  unknown  no
## 2070  2008-05-12      105        3    -1        0  unknown  no
## 2071  2008-05-12       62        2    -1        0  unknown  no
## 2072  2008-05-12       29        8    -1        0  unknown  no
## 2073  2008-05-12       59        4    -1        0  unknown  no
## 2074  2008-05-12      247        3    -1        0  unknown  no
## 2075  2008-05-12      160        4    -1        0  unknown  no
## 2076  2008-05-12      144        7    -1        0  unknown  no
## 2077  2008-05-12      346        4    -1        0  unknown  no
## 2078  2008-05-12       57        2    -1        0  unknown  no
## 2079  2008-05-12      396        3    -1        0  unknown  no
## 2080  2008-05-12      286        4    -1        0  unknown  no
## 2081  2008-05-12      400        3    -1        0  unknown  no
## 2082  2008-05-12      282        4    -1        0  unknown  no
## 2083  2008-05-12       38        4    -1        0  unknown  no
## 2084  2008-05-12      252        4    -1        0  unknown  no
## 2085  2008-05-12       76        3    -1        0  unknown  no
## 2086  2008-05-12      566        7    -1        0  unknown  no
## 2087  2008-05-12      167        2    -1        0  unknown  no
## 2088  2008-05-12      127        2    -1        0  unknown  no
## 2089  2008-05-12      178        2    -1        0  unknown  no
## 2090  2008-05-12       71        2    -1        0  unknown  no
## 2091  2008-05-12      109        2    -1        0  unknown  no
## 2092  2008-05-12      120        2    -1        0  unknown  no
## 2093  2008-05-12      102        3    -1        0  unknown  no
## 2094  2008-05-12      409        2    -1        0  unknown  no
## 2095  2008-05-12      117        2    -1        0  unknown  no
## 2096  2008-05-12      177        4    -1        0  unknown  no
## 2097  2008-05-12      757        2    -1        0  unknown yes
## 2098  2008-05-12      145        1    -1        0  unknown  no
## 2099  2008-05-12      124        1    -1        0  unknown  no
## 2100  2008-05-12       36        4    -1        0  unknown  no
## 2101  2008-05-12       94        2    -1        0  unknown  no
## 2102  2008-05-12      189        1    -1        0  unknown  no
## 2103  2008-05-12       24        1    -1        0  unknown  no
## 2104  2008-05-12       33        2    -1        0  unknown  no
## 2105  2008-05-12      185        1    -1        0  unknown  no
## 2106  2008-05-12      165        1    -1        0  unknown  no
## 2107  2008-05-12      405        3    -1        0  unknown  no
## 2108  2008-05-12      172        2    -1        0  unknown  no
## 2109  2008-05-12      207        3    -1        0  unknown  no
## 2110  2008-05-12      325        3    -1        0  unknown  no
## 2111  2008-05-12       57        8    -1        0  unknown  no
## 2112  2008-05-12      102        1    -1        0  unknown  no
## 2113  2008-05-12      378        3    -1        0  unknown  no
## 2114  2008-05-12      164        3    -1        0  unknown  no
## 2115  2008-05-12      288        2    -1        0  unknown  no
## 2116  2008-05-12      154        1    -1        0  unknown  no
## 2117  2008-05-12      102        1    -1        0  unknown  no
## 2118  2008-05-12      136        2    -1        0  unknown  no
## 2119  2008-05-12       53        1    -1        0  unknown  no
## 2120  2008-05-12      113        3    -1        0  unknown  no
## 2121  2008-05-12      110        3    -1        0  unknown  no
## 2122  2008-05-12      523        1    -1        0  unknown  no
## 2123  2008-05-12      231        1    -1        0  unknown  no
## 2124  2008-05-12      217        1    -1        0  unknown  no
## 2125  2008-05-12      151        1    -1        0  unknown  no
## 2126  2008-05-12      179        2    -1        0  unknown  no
## 2127  2008-05-12      293        1    -1        0  unknown  no
## 2128  2008-05-12      281        1    -1        0  unknown  no
## 2129  2008-05-12      363        2    -1        0  unknown  no
## 2130  2008-05-12       86        1    -1        0  unknown  no
## 2131  2008-05-12     1147        2    -1        0  unknown  no
## 2132  2008-05-12      209        1    -1        0  unknown  no
## 2133  2008-05-12      486        1    -1        0  unknown  no
## 2134  2008-05-12       49        2    -1        0  unknown  no
## 2135  2008-05-12      170        2    -1        0  unknown  no
## 2136  2008-05-12      539        1    -1        0  unknown  no
## 2137  2008-05-12       66        3    -1        0  unknown  no
## 2138  2008-05-12       51        1    -1        0  unknown  no
## 2139  2008-05-12      820        1    -1        0  unknown  no
## 2140  2008-05-12      125        1    -1        0  unknown  no
## 2141  2008-05-12      398        1    -1        0  unknown  no
## 2142  2008-05-12      112        1    -1        0  unknown  no
## 2143  2008-05-12       64        1    -1        0  unknown  no
## 2144  2008-05-12      255        1    -1        0  unknown  no
## 2145  2008-05-12       34        1    -1        0  unknown  no
## 2146  2008-05-12       95        8    -1        0  unknown  no
## 2147  2008-05-12      140        3    -1        0  unknown  no
## 2148  2008-05-12      788        2    -1        0  unknown  no
## 2149  2008-05-12      194        2    -1        0  unknown  no
## 2150  2008-05-12      165        4    -1        0  unknown  no
## 2151  2008-05-12      306        2    -1        0  unknown  no
## 2152  2008-05-12       63        3    -1        0  unknown  no
## 2153  2008-05-12      501        2    -1        0  unknown  no
## 2154  2008-05-12      832        3    -1        0  unknown  no
## 2155  2008-05-12      101        2    -1        0  unknown  no
## 2156  2008-05-12      214        4    -1        0  unknown  no
## 2157  2008-05-12      290        6    -1        0  unknown  no
## 2158  2008-05-12      388        2    -1        0  unknown  no
## 2159  2008-05-12     1495        4    -1        0  unknown  no
## 2160  2008-05-12      183        1    -1        0  unknown  no
## 2161  2008-05-12      322        1    -1        0  unknown  no
## 2162  2008-05-12      646        3    -1        0  unknown  no
## 2163  2008-05-12      480        1    -1        0  unknown  no
## 2164  2008-05-12      169        2    -1        0  unknown  no
## 2165  2008-05-12       74        1    -1        0  unknown  no
## 2166  2008-05-12      146        3    -1        0  unknown  no
## 2167  2008-05-12      393        1    -1        0  unknown  no
## 2168  2008-05-12      744        2    -1        0  unknown  no
## 2169  2008-05-12      593        2    -1        0  unknown  no
## 2170  2008-05-12      215        1    -1        0  unknown  no
## 2171  2008-05-12      379        2    -1        0  unknown  no
## 2172  2008-05-12      315        1    -1        0  unknown  no
## 2173  2008-05-12      162        1    -1        0  unknown  no
## 2174  2008-05-12      493        1    -1        0  unknown  no
## 2175  2008-05-12      225        1    -1        0  unknown  no
## 2176  2008-05-12      208        1    -1        0  unknown  no
## 2177  2008-05-12       80        4    -1        0  unknown  no
## 2178  2008-05-12        3        1    -1        0  unknown  no
## 2179  2008-05-12       29        1    -1        0  unknown  no
## 2180  2008-05-12      132        1    -1        0  unknown  no
## 2181  2008-05-12      379        2    -1        0  unknown  no
## 2182  2008-05-12      101        1    -1        0  unknown  no
## 2183  2008-05-12      188        1    -1        0  unknown  no
## 2184  2008-05-12      386        2    -1        0  unknown  no
## 2185  2008-05-12      457        4    -1        0  unknown  no
## 2186  2008-05-12      891        1    -1        0  unknown  no
## 2187  2008-05-12       53        1    -1        0  unknown  no
## 2188  2008-05-12      446        1    -1        0  unknown  no
## 2189  2008-05-12      326        1    -1        0  unknown  no
## 2190  2008-05-12      507        1    -1        0  unknown  no
## 2191  2008-05-12     1083        2    -1        0  unknown  no
## 2192  2008-05-12      123        2    -1        0  unknown  no
## 2193  2008-05-12     1266        1    -1        0  unknown  no
## 2194  2008-05-12      160        4    -1        0  unknown  no
## 2195  2008-05-12      139        2    -1        0  unknown  no
## 2196  2008-05-12      178        2    -1        0  unknown  no
## 2197  2008-05-12      156        3    -1        0  unknown  no
## 2198  2008-05-12      200        2    -1        0  unknown  no
## 2199  2008-05-12      154        2    -1        0  unknown  no
## 2200  2008-05-12      163        4    -1        0  unknown  no
## 2201  2008-05-12      391        1    -1        0  unknown  no
## 2202  2008-05-12      470        1    -1        0  unknown  no
## 2203  2008-05-12      268        4    -1        0  unknown  no
## 2204  2008-05-12      793        5    -1        0  unknown  no
## 2205  2008-05-12      619        3    -1        0  unknown  no
## 2206  2008-05-12      460        1    -1        0  unknown  no
## 2207  2008-05-12      246        1    -1        0  unknown  no
## 2208  2008-05-12      194        3    -1        0  unknown  no
## 2209  2008-05-12      413        1    -1        0  unknown  no
## 2210  2008-05-12      574        6    -1        0  unknown  no
## 2211  2008-05-12      256        4    -1        0  unknown  no
## 2212  2008-05-12       88        2    -1        0  unknown  no
## 2213  2008-05-12      146        1    -1        0  unknown  no
## 2214  2008-05-12      170        2    -1        0  unknown  no
## 2215  2008-05-12      596        1    -1        0  unknown  no
## 2216  2008-05-12      139        1    -1        0  unknown  no
## 2217  2008-05-12      177        3    -1        0  unknown  no
## 2218  2008-05-12      577        1    -1        0  unknown  no
## 2219  2008-05-12      335        1    -1        0  unknown  no
## 2220  2008-05-12      262        2    -1        0  unknown  no
## 2221  2008-05-12      115        1    -1        0  unknown  no
## 2222  2008-05-12      116        2    -1        0  unknown  no
## 2223  2008-05-12      136        4    -1        0  unknown  no
## 2224  2008-05-12      289        3    -1        0  unknown  no
## 2225  2008-05-12      529        2    -1        0  unknown  no
## 2226  2008-05-12      247        2    -1        0  unknown  no
## 2227  2008-05-12       72        2    -1        0  unknown  no
## 2228  2008-05-12      166        2    -1        0  unknown  no
## 2229  2008-05-12      152        2    -1        0  unknown  no
## 2230  2008-05-12      220        3    -1        0  unknown  no
## 2231  2008-05-12      241        3    -1        0  unknown  no
## 2232  2008-05-12      198        3    -1        0  unknown  no
## 2233  2008-05-12       98        2    -1        0  unknown  no
## 2234  2008-05-12      182        2    -1        0  unknown  no
## 2235  2008-05-12      391        2    -1        0  unknown  no
## 2236  2008-05-12      126        2    -1        0  unknown  no
## 2237  2008-05-12       55        2    -1        0  unknown  no
## 2238  2008-05-12      495        1    -1        0  unknown  no
## 2239  2008-05-12       86        4    -1        0  unknown  no
## 2240  2008-05-12      166        2    -1        0  unknown  no
## 2241  2008-05-12       66        4    -1        0  unknown  no
## 2242  2008-05-12      155        3    -1        0  unknown  no
## 2243  2008-05-12      311        3    -1        0  unknown  no
## 2244  2008-05-12       63        5    -1        0  unknown  no
## 2245  2008-05-12      236       10    -1        0  unknown  no
## 2246  2008-05-12       92        3    -1        0  unknown  no
## 2247  2008-05-12      298        2    -1        0  unknown  no
## 2248  2008-05-12      253        2    -1        0  unknown  no
## 2249  2008-05-12      163        2    -1        0  unknown  no
## 2250  2008-05-12       65        1    -1        0  unknown  no
## 2251  2008-05-12       41        1    -1        0  unknown  no
## 2252  2008-05-12       10       11    -1        0  unknown  no
## 2253  2008-05-12      221        1    -1        0  unknown  no
## 2254  2008-05-12      370        1    -1        0  unknown  no
## 2255  2008-05-12      467        5    -1        0  unknown  no
## 2256  2008-05-12      241        3    -1        0  unknown  no
## 2257  2008-05-12      248        2    -1        0  unknown  no
## 2258  2008-05-12      120        2    -1        0  unknown  no
## 2259  2008-05-12      260        2    -1        0  unknown  no
## 2260  2008-05-12      198        3    -1        0  unknown  no
## 2261  2008-05-12     1727        5    -1        0  unknown  no
## 2262  2008-05-12      138        8    -1        0  unknown  no
## 2263  2008-05-12      115        4    -1        0  unknown  no
## 2264  2008-05-12      212        2    -1        0  unknown  no
## 2265  2008-05-12       58        7    -1        0  unknown  no
## 2266  2008-05-12      456        6    -1        0  unknown  no
## 2267  2008-05-12      145        4    -1        0  unknown  no
## 2268  2008-05-12      289        3    -1        0  unknown  no
## 2269  2008-05-12      300        3    -1        0  unknown  no
## 2270  2008-05-12      264        2    -1        0  unknown  no
## 2271  2008-05-12      181        2    -1        0  unknown  no
## 2272  2008-05-12      184        4    -1        0  unknown  no
## 2273  2008-05-12      148        3    -1        0  unknown  no
## 2274  2008-05-12      166        4    -1        0  unknown  no
## 2275  2008-05-12       65        5    -1        0  unknown  no
## 2276  2008-05-12      299        5    -1        0  unknown  no
## 2277  2008-05-12       93        4    -1        0  unknown  no
## 2278  2008-05-12       22        5    -1        0  unknown  no
## 2279  2008-05-12      170        8    -1        0  unknown  no
## 2280  2008-05-12       89        3    -1        0  unknown  no
## 2281  2008-05-12      215        2    -1        0  unknown  no
## 2282  2008-05-12      166        4    -1        0  unknown  no
## 2283  2008-05-12      109        3    -1        0  unknown  no
## 2284  2008-05-12      197        3    -1        0  unknown  no
## 2285  2008-05-12      395        3    -1        0  unknown  no
## 2286  2008-05-12     1875        4    -1        0  unknown  no
## 2287  2008-05-12      220        2    -1        0  unknown  no
## 2288  2008-05-12      298        2    -1        0  unknown  no
## 2289  2008-05-12      123        7    -1        0  unknown  no
## 2290  2008-05-12      140        7    -1        0  unknown  no
## 2291  2008-05-12      334        7    -1        0  unknown  no
## 2292  2008-05-12       73        3    -1        0  unknown  no
## 2293  2008-05-12      186        6    -1        0  unknown  no
## 2294  2008-05-12       78        3    -1        0  unknown  no
## 2295  2008-05-12       13        5    -1        0  unknown  no
## 2296  2008-05-12       51        9    -1        0  unknown  no
## 2297  2008-05-12      303        3    -1        0  unknown  no
## 2298  2008-05-12      159        3    -1        0  unknown  no
## 2299  2008-05-12      103        8    -1        0  unknown  no
## 2300  2008-05-12       95        3    -1        0  unknown  no
## 2301  2008-05-12       84        3    -1        0  unknown  no
## 2302  2008-05-12      344        3    -1        0  unknown  no
## 2303  2008-05-12      246        6    -1        0  unknown  no
## 2304  2008-05-12      157        5    -1        0  unknown  no
## 2305  2008-05-12      162        4    -1        0  unknown  no
## 2306  2008-05-12       24       12    -1        0  unknown  no
## 2307  2008-05-12      212        5    -1        0  unknown  no
## 2308  2008-05-12      195        2    -1        0  unknown  no
## 2309  2008-05-12      143        4    -1        0  unknown  no
## 2310  2008-05-12       68        2    -1        0  unknown  no
## 2311  2008-05-12      274        6    -1        0  unknown  no
## 2312  2008-05-12      227        3    -1        0  unknown  no
## 2313  2008-05-12      152        5    -1        0  unknown  no
## 2314  2008-05-12      249        4    -1        0  unknown  no
## 2315  2008-05-12      325        4    -1        0  unknown  no
## 2316  2008-05-12      111        4    -1        0  unknown  no
## 2317  2008-05-12       81        4    -1        0  unknown  no
## 2318  2008-05-12      181        4    -1        0  unknown  no
## 2319  2008-05-13       85        2    -1        0  unknown  no
## 2320  2008-05-13      141        6    -1        0  unknown  no
## 2321  2008-05-13       42        3    -1        0  unknown  no
## 2322  2008-05-13      182        6    -1        0  unknown  no
## 2323  2008-05-13      160        3    -1        0  unknown  no
## 2324  2008-05-13      176        4    -1        0  unknown  no
## 2325  2008-05-13      134        2    -1        0  unknown  no
## 2326  2008-05-13      514        5    -1        0  unknown  no
## 2327  2008-05-13      181        5    -1        0  unknown  no
## 2328  2008-05-13      160        3    -1        0  unknown  no
## 2329  2008-05-13      504        4    -1        0  unknown yes
## 2330  2008-05-13      267        3    -1        0  unknown  no
## 2331  2008-05-13      907        2    -1        0  unknown  no
## 2332  2008-05-13      200        1    -1        0  unknown  no
## 2333  2008-05-13      139        1    -1        0  unknown  no
## 2334  2008-05-13      147        1    -1        0  unknown  no
## 2335  2008-05-13      161        1    -1        0  unknown  no
## 2336  2008-05-13      153        1    -1        0  unknown  no
## 2337  2008-05-13      109        1    -1        0  unknown  no
## 2338  2008-05-13       97        2    -1        0  unknown  no
## 2339  2008-05-13      164        1    -1        0  unknown  no
## 2340  2008-05-13       70        1    -1        0  unknown  no
## 2341  2008-05-13       71        1    -1        0  unknown  no
## 2342  2008-05-13      723        1    -1        0  unknown  no
## 2343  2008-05-13      518        1    -1        0  unknown  no
## 2344  2008-05-13      704        1    -1        0  unknown  no
## 2345  2008-05-13      147        1    -1        0  unknown  no
## 2346  2008-05-13      101        1    -1        0  unknown  no
## 2347  2008-05-13      142        1    -1        0  unknown  no
## 2348  2008-05-13     1346        1    -1        0  unknown yes
## 2349  2008-05-13      520        1    -1        0  unknown  no
## 2350  2008-05-13      611        2    -1        0  unknown  no
## 2351  2008-05-13       66        1    -1        0  unknown  no
## 2352  2008-05-13      135        3    -1        0  unknown  no
## 2353  2008-05-13      276        2    -1        0  unknown  no
## 2354  2008-05-13      449        1    -1        0  unknown  no
## 2355  2008-05-13       98        1    -1        0  unknown  no
## 2356  2008-05-13      105        1    -1        0  unknown  no
## 2357  2008-05-13      382        2    -1        0  unknown  no
## 2358  2008-05-13      213        1    -1        0  unknown  no
## 2359  2008-05-13      116        1    -1        0  unknown  no
## 2360  2008-05-13      125        1    -1        0  unknown  no
## 2361  2008-05-13       50        1    -1        0  unknown  no
## 2362  2008-05-13      138        1    -1        0  unknown  no
## 2363  2008-05-13      375        1    -1        0  unknown  no
## 2364  2008-05-13       49        1    -1        0  unknown  no
## 2365  2008-05-13      169        1    -1        0  unknown  no
## 2366  2008-05-13      178        2    -1        0  unknown  no
## 2367  2008-05-13     1386        1    -1        0  unknown  no
## 2368  2008-05-13      155        1    -1        0  unknown  no
## 2369  2008-05-13      120        1    -1        0  unknown  no
## 2370  2008-05-13      203        1    -1        0  unknown  no
## 2371  2008-05-13      244        1    -1        0  unknown  no
## 2372  2008-05-13      428        1    -1        0  unknown  no
## 2373  2008-05-13       53        1    -1        0  unknown  no
## 2374  2008-05-13      360        1    -1        0  unknown  no
## 2375  2008-05-13      215        1    -1        0  unknown  no
## 2376  2008-05-13      500        2    -1        0  unknown  no
## 2377  2008-05-13      207        1    -1        0  unknown  no
## 2378  2008-05-13      568        4    -1        0  unknown yes
## 2379  2008-05-13      270        1    -1        0  unknown  no
## 2380  2008-05-13      154        1    -1        0  unknown  no
## 2381  2008-05-13      272        1    -1        0  unknown  no
## 2382  2008-05-13      229        1    -1        0  unknown  no
## 2383  2008-05-13      108        1    -1        0  unknown  no
## 2384  2008-05-13      210        1    -1        0  unknown  no
## 2385  2008-05-13      383        1    -1        0  unknown  no
## 2386  2008-05-13      259        6    -1        0  unknown  no
## 2387  2008-05-13     3366        3    -1        0  unknown  no
## 2388  2008-05-13     1000        1    -1        0  unknown yes
## 2389  2008-05-13      618        1    -1        0  unknown yes
## 2390  2008-05-13      415        1    -1        0  unknown  no
## 2391  2008-05-13      237        1    -1        0  unknown  no
## 2392  2008-05-13      106        1    -1        0  unknown  no
## 2393  2008-05-13      351        1    -1        0  unknown  no
## 2394  2008-05-13      218        1    -1        0  unknown  no
## 2395  2008-05-13      198        1    -1        0  unknown  no
## 2396  2008-05-13      284        2    -1        0  unknown  no
## 2397  2008-05-13      190        1    -1        0  unknown  no
## 2398  2008-05-13      295        1    -1        0  unknown  no
## 2399  2008-05-13      262        1    -1        0  unknown  no
## 2400  2008-05-13      106        1    -1        0  unknown  no
## 2401  2008-05-13       93        1    -1        0  unknown  no
## 2402  2008-05-13      174        1    -1        0  unknown  no
## 2403  2008-05-13      124        1    -1        0  unknown  no
## 2404  2008-05-13      217        1    -1        0  unknown  no
## 2405  2008-05-13     2231        1    -1        0  unknown yes
## 2406  2008-05-13      343        1    -1        0  unknown  no
## 2407  2008-05-13      227        4    -1        0  unknown  no
## 2408  2008-05-13      248        2    -1        0  unknown  no
## 2409  2008-05-13      180        1    -1        0  unknown  no
## 2410  2008-05-13      117        1    -1        0  unknown  no
## 2411  2008-05-13      205        1    -1        0  unknown  no
## 2412  2008-05-13      370        1    -1        0  unknown  no
## 2413  2008-05-13      289        2    -1        0  unknown  no
## 2414  2008-05-13      427        1    -1        0  unknown  no
## 2415  2008-05-13      170        1    -1        0  unknown  no
## 2416  2008-05-13      705        1    -1        0  unknown  no
## 2417  2008-05-13      247        1    -1        0  unknown  no
## 2418  2008-05-13      226        1    -1        0  unknown  no
## 2419  2008-05-13      665        1    -1        0  unknown  no
## 2420  2008-05-13      213        1    -1        0  unknown  no
## 2421  2008-05-13      451        1    -1        0  unknown  no
## 2422  2008-05-13      174        1    -1        0  unknown  no
## 2423  2008-05-13      126        5    -1        0  unknown  no
## 2424  2008-05-13      243        3    -1        0  unknown  no
## 2425  2008-05-13      166        1    -1        0  unknown  no
## 2426  2008-05-13      373        1    -1        0  unknown  no
## 2427  2008-05-13      259        1    -1        0  unknown  no
## 2428  2008-05-13      340        1    -1        0  unknown  no
## 2429  2008-05-13      193        1    -1        0  unknown  no
## 2430  2008-05-13      392        1    -1        0  unknown  no
## 2431  2008-05-13      136        1    -1        0  unknown  no
## 2432  2008-05-13      148        1    -1        0  unknown  no
## 2433  2008-05-13      456        1    -1        0  unknown  no
## 2434  2008-05-13      107        1    -1        0  unknown  no
## 2435  2008-05-13       44        1    -1        0  unknown  no
## 2436  2008-05-13      118        1    -1        0  unknown  no
## 2437  2008-05-13      276        1    -1        0  unknown  no
## 2438  2008-05-13       47        1    -1        0  unknown  no
## 2439  2008-05-13      150        2    -1        0  unknown  no
## 2440  2008-05-13      118        1    -1        0  unknown  no
## 2441  2008-05-13      232        3    -1        0  unknown  no
## 2442  2008-05-13     1167        1    -1        0  unknown  no
## 2443  2008-05-13      227        1    -1        0  unknown  no
## 2444  2008-05-13      325        1    -1        0  unknown  no
## 2445  2008-05-13      147        1    -1        0  unknown  no
## 2446  2008-05-13       98        1    -1        0  unknown  no
## 2447  2008-05-13       93        1    -1        0  unknown  no
## 2448  2008-05-13       83        1    -1        0  unknown  no
## 2449  2008-05-13      105        1    -1        0  unknown  no
## 2450  2008-05-13       67        1    -1        0  unknown  no
## 2451  2008-05-13       77        1    -1        0  unknown  no
## 2452  2008-05-13      191        1    -1        0  unknown  no
## 2453  2008-05-13       20        1    -1        0  unknown  no
## 2454  2008-05-13       27        1    -1        0  unknown  no
## 2455  2008-05-13      260        3    -1        0  unknown  no
## 2456  2008-05-13      174        4    -1        0  unknown  no
## 2457  2008-05-13       94        1    -1        0  unknown  no
## 2458  2008-05-13       23        2    -1        0  unknown  no
## 2459  2008-05-13      334        1    -1        0  unknown  no
## 2460  2008-05-13      609        2    -1        0  unknown  no
## 2461  2008-05-13      202        1    -1        0  unknown  no
## 2462  2008-05-13      302        1    -1        0  unknown  no
## 2463  2008-05-13      121        2    -1        0  unknown  no
## 2464  2008-05-13      202        3    -1        0  unknown  no
## 2465  2008-05-13      806        1    -1        0  unknown  no
## 2466  2008-05-13       31        1    -1        0  unknown  no
## 2467  2008-05-13       21        1    -1        0  unknown  no
## 2468  2008-05-13      156        1    -1        0  unknown  no
## 2469  2008-05-13       92        1    -1        0  unknown  no
## 2470  2008-05-13      128        2    -1        0  unknown  no
## 2471  2008-05-13      481        1    -1        0  unknown  no
## 2472  2008-05-13      766        1    -1        0  unknown  no
## 2473  2008-05-13      255        5    -1        0  unknown  no
## 2474  2008-05-13      110        1    -1        0  unknown  no
## 2475  2008-05-13      395        2    -1        0  unknown yes
## 2476  2008-05-13      135        1    -1        0  unknown  no
## 2477  2008-05-13      192        1    -1        0  unknown  no
## 2478  2008-05-13      188        2    -1        0  unknown  no
## 2479  2008-05-13      139        1    -1        0  unknown  no
## 2480  2008-05-13      131        1    -1        0  unknown  no
## 2481  2008-05-13      266        2    -1        0  unknown  no
## 2482  2008-05-13       76        1    -1        0  unknown  no
## 2483  2008-05-13      122        1    -1        0  unknown  no
## 2484  2008-05-13     1015        1    -1        0  unknown yes
## 2485  2008-05-13       60        1    -1        0  unknown  no
## 2486  2008-05-13      683        2    -1        0  unknown yes
## 2487  2008-05-13      470        1    -1        0  unknown yes
## 2488  2008-05-13      149        1    -1        0  unknown  no
## 2489  2008-05-13      106        1    -1        0  unknown  no
## 2490  2008-05-13      127        2    -1        0  unknown  no
## 2491  2008-05-13      320        1    -1        0  unknown  no
## 2492  2008-05-13      145        1    -1        0  unknown  no
## 2493  2008-05-13      129        1    -1        0  unknown  no
## 2494  2008-05-13      730        1    -1        0  unknown  no
## 2495  2008-05-13       36        1    -1        0  unknown  no
## 2496  2008-05-13      521        1    -1        0  unknown  no
## 2497  2008-05-13       95        3    -1        0  unknown  no
## 2498  2008-05-13      120        1    -1        0  unknown  no
## 2499  2008-05-13      768        1    -1        0  unknown  no
## 2500  2008-05-13      277        1    -1        0  unknown  no
## 2501  2008-05-13      289        1    -1        0  unknown  no
## 2502  2008-05-13      473        1    -1        0  unknown  no
## 2503  2008-05-13      133        1    -1        0  unknown  no
## 2504  2008-05-13      459        1    -1        0  unknown  no
## 2505  2008-05-13      129        1    -1        0  unknown  no
## 2506  2008-05-13      420        1    -1        0  unknown  no
## 2507  2008-05-13      386        2    -1        0  unknown  no
## 2508  2008-05-13     1001        4    -1        0  unknown yes
## 2509  2008-05-13       76        1    -1        0  unknown  no
## 2510  2008-05-13      488        1    -1        0  unknown  no
## 2511  2008-05-13      262        1    -1        0  unknown  no
## 2512  2008-05-13      146        1    -1        0  unknown  no
## 2513  2008-05-13      503        1    -1        0  unknown  no
## 2514  2008-05-13      170        1    -1        0  unknown  no
## 2515  2008-05-13      214        1    -1        0  unknown  no
## 2516  2008-05-13      355        1    -1        0  unknown  no
## 2517  2008-05-13      194        2    -1        0  unknown  no
## 2518  2008-05-13       46        1    -1        0  unknown  no
## 2519  2008-05-13      128        1    -1        0  unknown  no
## 2520  2008-05-13      845        1    -1        0  unknown yes
## 2521  2008-05-13       52        2    -1        0  unknown  no
## 2522  2008-05-13      173        1    -1        0  unknown  no
## 2523  2008-05-13      113        2    -1        0  unknown  no
## 2524  2008-05-13      109        2    -1        0  unknown  no
## 2525  2008-05-13      853        1    -1        0  unknown  no
## 2526  2008-05-13      518        1    -1        0  unknown  no
## 2527  2008-05-13      124        2    -1        0  unknown  no
## 2528  2008-05-13      452        2    -1        0  unknown  no
## 2529  2008-05-13      209        9    -1        0  unknown  no
## 2530  2008-05-13      154        2    -1        0  unknown  no
## 2531  2008-05-13      203        2    -1        0  unknown  no
## 2532  2008-05-13      813        2    -1        0  unknown  no
## 2533  2008-05-13       81        1    -1        0  unknown  no
## 2534  2008-05-13      119        1    -1        0  unknown  no
## 2535  2008-05-13      296        1    -1        0  unknown  no
## 2536  2008-05-13      916        2    -1        0  unknown  no
## 2537  2008-05-13       60        2    -1        0  unknown  no
## 2538  2008-05-13      443        1    -1        0  unknown  no
## 2539  2008-05-13      353        1    -1        0  unknown  no
## 2540  2008-05-13      225        2    -1        0  unknown  no
## 2541  2008-05-13      262        2    -1        0  unknown  no
## 2542  2008-05-13      431        2    -1        0  unknown  no
## 2543  2008-05-13      358        2    -1        0  unknown  no
## 2544  2008-05-13      565        2    -1        0  unknown  no
## 2545  2008-05-13      103        3    -1        0  unknown  no
## 2546  2008-05-13      753        6    -1        0  unknown yes
## 2547  2008-05-13      708        2    -1        0  unknown  no
## 2548  2008-05-13      265        1    -1        0  unknown  no
## 2549  2008-05-13      434        2    -1        0  unknown  no
## 2550  2008-05-13       59        1    -1        0  unknown  no
## 2551  2008-05-13      805        2    -1        0  unknown  no
## 2552  2008-05-13      242        1    -1        0  unknown  no
## 2553  2008-05-13       19        9    -1        0  unknown  no
## 2554  2008-05-13       93        6    -1        0  unknown  no
## 2555  2008-05-13      210        8    -1        0  unknown  no
## 2556  2008-05-13       31        2    -1        0  unknown  no
## 2557  2008-05-13      213        5    -1        0  unknown  no
## 2558  2008-05-13      104        2    -1        0  unknown  no
## 2559  2008-05-13      342        3    -1        0  unknown  no
## 2560  2008-05-13      172        2    -1        0  unknown  no
## 2561  2008-05-13      160        3    -1        0  unknown  no
## 2562  2008-05-13      535        2    -1        0  unknown  no
## 2563  2008-05-13      514        5    -1        0  unknown  no
## 2564  2008-05-13      276        1    -1        0  unknown  no
## 2565  2008-05-13      176        3    -1        0  unknown  no
## 2566  2008-05-13       20        1    -1        0  unknown  no
## 2567  2008-05-13      161        1    -1        0  unknown  no
## 2568  2008-05-13      390        1    -1        0  unknown  no
## 2569  2008-05-13      245        4    -1        0  unknown  no
## 2570  2008-05-13      151        1    -1        0  unknown  no
## 2571  2008-05-13      144        1    -1        0  unknown  no
## 2572  2008-05-13      901        2    -1        0  unknown  no
## 2573  2008-05-13      123        1    -1        0  unknown  no
## 2574  2008-05-13      204        3    -1        0  unknown  no
## 2575  2008-05-13       93        2    -1        0  unknown  no
## 2576  2008-05-13      188        3    -1        0  unknown  no
## 2577  2008-05-13      332        1    -1        0  unknown  no
## 2578  2008-05-13      180        1    -1        0  unknown  no
## 2579  2008-05-13      178        2    -1        0  unknown  no
## 2580  2008-05-13       92        1    -1        0  unknown  no
## 2581  2008-05-13      318        2    -1        0  unknown  no
## 2582  2008-05-13       94        1    -1        0  unknown  no
## 2583  2008-05-13      139        2    -1        0  unknown  no
## 2584  2008-05-13      152        1    -1        0  unknown  no
## 2585  2008-05-13      188        1    -1        0  unknown  no
## 2586  2008-05-13       54        3    -1        0  unknown  no
## 2587  2008-05-13       29        1    -1        0  unknown  no
## 2588  2008-05-13      271        1    -1        0  unknown  no
## 2589  2008-05-13       95        1    -1        0  unknown  no
## 2590  2008-05-13      227        1    -1        0  unknown  no
## 2591  2008-05-13      190        1    -1        0  unknown  no
## 2592  2008-05-13       60        1    -1        0  unknown  no
## 2593  2008-05-13      161        1    -1        0  unknown  no
## 2594  2008-05-13      162        4    -1        0  unknown  no
## 2595  2008-05-13      213        2    -1        0  unknown  no
## 2596  2008-05-13       67        2    -1        0  unknown  no
## 2597  2008-05-13       93        1    -1        0  unknown  no
## 2598  2008-05-13      119        2    -1        0  unknown  no
## 2599  2008-05-13      297        3    -1        0  unknown  no
## 2600  2008-05-13        3        1    -1        0  unknown  no
## 2601  2008-05-13      179        1    -1        0  unknown  no
## 2602  2008-05-13      342        2    -1        0  unknown  no
## 2603  2008-05-13      420        1    -1        0  unknown  no
## 2604  2008-05-13      378        1    -1        0  unknown  no
## 2605  2008-05-13      190        1    -1        0  unknown  no
## 2606  2008-05-13      354        2    -1        0  unknown  no
## 2607  2008-05-13      190        1    -1        0  unknown  no
## 2608  2008-05-13      367        1    -1        0  unknown  no
## 2609  2008-05-13       91        2    -1        0  unknown  no
## 2610  2008-05-13       77        1    -1        0  unknown  no
## 2611  2008-05-13      280        1    -1        0  unknown  no
## 2612  2008-05-13      182        1    -1        0  unknown  no
## 2613  2008-05-13      386        1    -1        0  unknown  no
## 2614  2008-05-13      184        1    -1        0  unknown  no
## 2615  2008-05-13       43        2    -1        0  unknown  no
## 2616  2008-05-13      108        2    -1        0  unknown  no
## 2617  2008-05-13      253        2    -1        0  unknown  no
## 2618  2008-05-13      195        2    -1        0  unknown  no
## 2619  2008-05-13       46        3    -1        0  unknown  no
## 2620  2008-05-13      226        1    -1        0  unknown  no
## 2621  2008-05-13       55        1    -1        0  unknown  no
## 2622  2008-05-13      299        3    -1        0  unknown  no
## 2623  2008-05-13      148        1    -1        0  unknown  no
## 2624  2008-05-13       97        1    -1        0  unknown  no
## 2625  2008-05-13      169        2    -1        0  unknown  no
## 2626  2008-05-13      119       10    -1        0  unknown  no
## 2627  2008-05-13      101       13    -1        0  unknown  no
## 2628  2008-05-13       60        1    -1        0  unknown  no
## 2629  2008-05-13      210        1    -1        0  unknown  no
## 2630  2008-05-13       65        6    -1        0  unknown  no
## 2631  2008-05-13      129        4    -1        0  unknown  no
## 2632  2008-05-13      481        3    -1        0  unknown  no
## 2633  2008-05-13      215        1    -1        0  unknown  no
## 2634  2008-05-13      142        2    -1        0  unknown  no
## 2635  2008-05-13      411        2    -1        0  unknown  no
## 2636  2008-05-13      531        2    -1        0  unknown  no
## 2637  2008-05-13       65        1    -1        0  unknown  no
## 2638  2008-05-13       34        4    -1        0  unknown  no
## 2639  2008-05-13      788        3    -1        0  unknown  no
## 2640  2008-05-13      244        1    -1        0  unknown  no
## 2641  2008-05-13      431        1    -1        0  unknown  no
## 2642  2008-05-13      851        4    -1        0  unknown  no
## 2643  2008-05-13      315        3    -1        0  unknown  no
## 2644  2008-05-13      214        1    -1        0  unknown  no
## 2645  2008-05-13       92        4    -1        0  unknown  no
## 2646  2008-05-13       73        3    -1        0  unknown  no
## 2647  2008-05-13      181        3    -1        0  unknown  no
## 2648  2008-05-13      159        2    -1        0  unknown  no
## 2649  2008-05-13       58        2    -1        0  unknown  no
## 2650  2008-05-13     1052        1    -1        0  unknown  no
## 2651  2008-05-13      916        2    -1        0  unknown yes
## 2652  2008-05-13      150        2    -1        0  unknown  no
## 2653  2008-05-13      165        2    -1        0  unknown  no
## 2654  2008-05-13      309        2    -1        0  unknown  no
## 2655  2008-05-13      163        2    -1        0  unknown  no
## 2656  2008-05-13      210        3    -1        0  unknown  no
## 2657  2008-05-13      165        3    -1        0  unknown  no
## 2658  2008-05-13      331        2    -1        0  unknown  no
## 2659  2008-05-13      134        2    -1        0  unknown  no
## 2660  2008-05-13      185        6    -1        0  unknown  no
## 2661  2008-05-13      295        2    -1        0  unknown  no
## 2662  2008-05-13       86        4    -1        0  unknown  no
## 2663  2008-05-13      274        2    -1        0  unknown  no
## 2664  2008-05-13      151        4    -1        0  unknown  no
## 2665  2008-05-13       69       11    -1        0  unknown  no
## 2666  2008-05-13       15       11    -1        0  unknown  no
## 2667  2008-05-13      164        2    -1        0  unknown  no
## 2668  2008-05-13      437        2    -1        0  unknown  no
## 2669  2008-05-13      139        4    -1        0  unknown  no
## 2670  2008-05-13      267        2    -1        0  unknown  no
## 2671  2008-05-13      165        2    -1        0  unknown  no
## 2672  2008-05-13      175        2    -1        0  unknown  no
## 2673  2008-05-13      198        2    -1        0  unknown  no
## 2674  2008-05-13      220        2    -1        0  unknown  no
## 2675  2008-05-13      168        2    -1        0  unknown  no
## 2676  2008-05-13      247        3    -1        0  unknown  no
## 2677  2008-05-13      291        2    -1        0  unknown  no
## 2678  2008-05-13      187        2    -1        0  unknown  no
## 2679  2008-05-13      194        2    -1        0  unknown  no
## 2680  2008-05-13      379        2    -1        0  unknown  no
## 2681  2008-05-13      151        2    -1        0  unknown  no
## 2682  2008-05-13      166        4    -1        0  unknown  no
## 2683  2008-05-13       64        2    -1        0  unknown  no
## 2684  2008-05-13      232        4    -1        0  unknown  no
## 2685  2008-05-13      647        7    -1        0  unknown  no
## 2686  2008-05-13      322        3    -1        0  unknown  no
## 2687  2008-05-13      133       12    -1        0  unknown  no
## 2688  2008-05-13       50        3    -1        0  unknown  no
## 2689  2008-05-13       87        2    -1        0  unknown  no
## 2690  2008-05-13      771        2    -1        0  unknown  no
## 2691  2008-05-13      241        2    -1        0  unknown  no
## 2692  2008-05-13      205        3    -1        0  unknown  no
## 2693  2008-05-13      318        2    -1        0  unknown  no
## 2694  2008-05-13      109        9    -1        0  unknown  no
## 2695  2008-05-13      304        2    -1        0  unknown  no
## 2696  2008-05-13      209        2    -1        0  unknown  no
## 2697  2008-05-13       83        7    -1        0  unknown  no
## 2698  2008-05-13      227        2    -1        0  unknown  no
## 2699  2008-05-13      271        2    -1        0  unknown  no
## 2700  2008-05-13      326        4    -1        0  unknown  no
## 2701  2008-05-13      389        2    -1        0  unknown  no
## 2702  2008-05-13      273        2    -1        0  unknown  no
## 2703  2008-05-13      264        3    -1        0  unknown  no
## 2704  2008-05-13     1106        4    -1        0  unknown  no
## 2705  2008-05-13       73        2    -1        0  unknown  no
## 2706  2008-05-13      195        5    -1        0  unknown  no
## 2707  2008-05-13       69       19    -1        0  unknown  no
## 2708  2008-05-13       87        9    -1        0  unknown  no
## 2709  2008-05-13      122        7    -1        0  unknown  no
## 2710  2008-05-13      945        2    -1        0  unknown yes
## 2711  2008-05-13      288        2    -1        0  unknown  no
## 2712  2008-05-13       50        3    -1        0  unknown  no
## 2713  2008-05-13      816        3    -1        0  unknown  no
## 2714  2008-05-13      284        2    -1        0  unknown  no
## 2715  2008-05-13      116        4    -1        0  unknown  no
## 2716  2008-05-13       72        4    -1        0  unknown  no
## 2717  2008-05-13      232        2    -1        0  unknown  no
## 2718  2008-05-13      124        3    -1        0  unknown  no
## 2719  2008-05-13      326        3    -1        0  unknown  no
## 2720  2008-05-13      190        5    -1        0  unknown  no
## 2721  2008-05-13     1721        2    -1        0  unknown yes
## 2722  2008-05-13      351        2    -1        0  unknown  no
## 2723  2008-05-13      171        2    -1        0  unknown  no
## 2724  2008-05-13      166        2    -1        0  unknown  no
## 2725  2008-05-13      104        2    -1        0  unknown  no
## 2726  2008-05-13      163        3    -1        0  unknown  no
## 2727  2008-05-13      492        2    -1        0  unknown  no
## 2728  2008-05-13       25       10    -1        0  unknown  no
## 2729  2008-05-13      152        3    -1        0  unknown  no
## 2730  2008-05-13      109        4    -1        0  unknown  no
## 2731  2008-05-13     1032        1    -1        0  unknown  no
## 2732  2008-05-14       65        6    -1        0  unknown  no
## 2733  2008-05-14      194        4    -1        0  unknown  no
## 2734  2008-05-14      360        2    -1        0  unknown  no
## 2735  2008-05-14       96        4    -1        0  unknown  no
## 2736  2008-05-14       20       11    -1        0  unknown  no
## 2737  2008-05-14      323        4    -1        0  unknown  no
## 2738  2008-05-14      332        2    -1        0  unknown  no
## 2739  2008-05-14      735        8    -1        0  unknown  no
## 2740  2008-05-14      151        2    -1        0  unknown  no
## 2741  2008-05-14       46        5    -1        0  unknown  no
## 2742  2008-05-14      158        3    -1        0  unknown  no
## 2743  2008-05-14       73        2    -1        0  unknown  no
## 2744  2008-05-14      407        4    -1        0  unknown  no
## 2745  2008-05-14      438        2    -1        0  unknown  no
## 2746  2008-05-14      139        2    -1        0  unknown  no
## 2747  2008-05-14      174        3    -1        0  unknown  no
## 2748  2008-05-14      175        3    -1        0  unknown  no
## 2749  2008-05-14      313        4    -1        0  unknown  no
## 2750  2008-05-14      137        4    -1        0  unknown  no
## 2751  2008-05-14       22        3    -1        0  unknown  no
## 2752  2008-05-14      328        4    -1        0  unknown  no
## 2753  2008-05-14       93        4    -1        0  unknown  no
## 2754  2008-05-14       97        2    -1        0  unknown  no
## 2755  2008-05-14      123        5    -1        0  unknown  no
## 2756  2008-05-14      219        4    -1        0  unknown  no
## 2757  2008-05-14      455        3    -1        0  unknown  no
## 2758  2008-05-14      103        6    -1        0  unknown  no
## 2759  2008-05-14      200        2    -1        0  unknown  no
## 2760  2008-05-14      133        2    -1        0  unknown  no
## 2761  2008-05-14       35        2    -1        0  unknown  no
## 2762  2008-05-14       77        2    -1        0  unknown  no
## 2763  2008-05-14      211        2    -1        0  unknown  no
## 2764  2008-05-14       72        2    -1        0  unknown  no
## 2765  2008-05-14      133        2    -1        0  unknown  no
## 2766  2008-05-14       89        2    -1        0  unknown  no
## 2767  2008-05-14      287        3    -1        0  unknown  no
## 2768  2008-05-14      942        3    -1        0  unknown yes
## 2769  2008-05-14      101        2    -1        0  unknown  no
## 2770  2008-05-14      305        3    -1        0  unknown  no
## 2771  2008-05-14      387        9    -1        0  unknown  no
## 2772  2008-05-14      146        4    -1        0  unknown  no
## 2773  2008-05-14      160        1    -1        0  unknown  no
## 2774  2008-05-14       70        1    -1        0  unknown  no
## 2775  2008-05-14      466        1    -1        0  unknown  no
## 2776  2008-05-14      162        1    -1        0  unknown  no
## 2777  2008-05-14      117        4    -1        0  unknown  no
## 2778  2008-05-14      381        1    -1        0  unknown  no
## 2779  2008-05-14      167        1    -1        0  unknown  no
## 2780  2008-05-14      476        1    -1        0  unknown yes
## 2781  2008-05-14      178        1    -1        0  unknown  no
## 2782  2008-05-14      260        1    -1        0  unknown  no
## 2783  2008-05-14      231        1    -1        0  unknown  no
## 2784  2008-05-14      188        1    -1        0  unknown  no
## 2785  2008-05-14      145        1    -1        0  unknown  no
## 2786  2008-05-14      163        3    -1        0  unknown  no
## 2787  2008-05-14      282        1    -1        0  unknown  no
## 2788  2008-05-14       74        1    -1        0  unknown  no
## 2789  2008-05-14       73        1    -1        0  unknown  no
## 2790  2008-05-14      220        1    -1        0  unknown  no
## 2791  2008-05-14      333        1    -1        0  unknown  no
## 2792  2008-05-14      316        3    -1        0  unknown  no
## 2793  2008-05-14      451        3    -1        0  unknown  no
## 2794  2008-05-14      318        1    -1        0  unknown  no
## 2795  2008-05-14      246        2    -1        0  unknown  no
## 2796  2008-05-14      311        2    -1        0  unknown  no
## 2797  2008-05-14      202        2    -1        0  unknown  no
## 2798  2008-05-14      174        2    -1        0  unknown  no
## 2799  2008-05-14      168        3    -1        0  unknown  no
## 2800  2008-05-14      832        1    -1        0  unknown yes
## 2801  2008-05-14      230        1    -1        0  unknown  no
## 2802  2008-05-14      200        1    -1        0  unknown  no
## 2803  2008-05-14      170        1    -1        0  unknown  no
## 2804  2008-05-14      142        1    -1        0  unknown  no
## 2805  2008-05-14      283        8    -1        0  unknown  no
## 2806  2008-05-14      421        1    -1        0  unknown  no
## 2807  2008-05-14      278        1    -1        0  unknown  no
## 2808  2008-05-14      179        1    -1        0  unknown  no
## 2809  2008-05-14      238        1    -1        0  unknown  no
## 2810  2008-05-14      110        2    -1        0  unknown  no
## 2811  2008-05-14      138        3    -1        0  unknown  no
## 2812  2008-05-14      218        2    -1        0  unknown  no
## 2813  2008-05-14      158        2    -1        0  unknown  no
## 2814  2008-05-14      105        1    -1        0  unknown  no
## 2815  2008-05-14      106        1    -1        0  unknown  no
## 2816  2008-05-14      217        1    -1        0  unknown  no
## 2817  2008-05-14      132        1    -1        0  unknown  no
## 2818  2008-05-14      824        2    -1        0  unknown  no
## 2819  2008-05-14      243        1    -1        0  unknown  no
## 2820  2008-05-14      150        1    -1        0  unknown  no
## 2821  2008-05-14      238        1    -1        0  unknown  no
## 2822  2008-05-14     1553        1    -1        0  unknown yes
## 2823  2008-05-14      148        2    -1        0  unknown  no
## 2824  2008-05-14      159        2    -1        0  unknown  no
## 2825  2008-05-14      108        2    -1        0  unknown  no
## 2826  2008-05-14      124        1    -1        0  unknown  no
## 2827  2008-05-14      452        1    -1        0  unknown  no
## 2828  2008-05-14      114        1    -1        0  unknown  no
## 2829  2008-05-14      125        1    -1        0  unknown  no
## 2830  2008-05-14      622        1    -1        0  unknown  no
## 2831  2008-05-14      153        1    -1        0  unknown  no
## 2832  2008-05-14     1328        1    -1        0  unknown yes
## 2833  2008-05-14      686        1    -1        0  unknown  no
## 2834  2008-05-14       80        1    -1        0  unknown  no
## 2835  2008-05-14      435        1    -1        0  unknown  no
## 2836  2008-05-14      300        1    -1        0  unknown  no
## 2837  2008-05-14      203        1    -1        0  unknown  no
## 2838  2008-05-14      121        1    -1        0  unknown  no
## 2839  2008-05-14       71        1    -1        0  unknown  no
## 2840  2008-05-14       78        1    -1        0  unknown  no
## 2841  2008-05-14      534        1    -1        0  unknown  no
## 2842  2008-05-14      243        1    -1        0  unknown  no
## 2843  2008-05-14      230        1    -1        0  unknown  no
## 2844  2008-05-14      253        1    -1        0  unknown  no
## 2845  2008-05-14      127        3    -1        0  unknown  no
## 2846  2008-05-14     1125        2    -1        0  unknown yes
## 2847  2008-05-14      282        1    -1        0  unknown  no
## 2848  2008-05-14      220        1    -1        0  unknown  no
## 2849  2008-05-14      158        2    -1        0  unknown  no
## 2850  2008-05-14      267        2    -1        0  unknown  no
## 2851  2008-05-14      257        1    -1        0  unknown  no
## 2852  2008-05-14      110        1    -1        0  unknown  no
## 2853  2008-05-14      456        9    -1        0  unknown  no
## 2854  2008-05-14       78        1    -1        0  unknown  no
## 2855  2008-05-14      298        1    -1        0  unknown  no
## 2856  2008-05-14      429        2    -1        0  unknown  no
## 2857  2008-05-14      483        2    -1        0  unknown  no
## 2858  2008-05-14      213        1    -1        0  unknown  no
## 2859  2008-05-14       51        1    -1        0  unknown  no
## 2860  2008-05-14       44        1    -1        0  unknown  no
## 2861  2008-05-14      164        2    -1        0  unknown  no
## 2862  2008-05-14      166        1    -1        0  unknown  no
## 2863  2008-05-14      220        2    -1        0  unknown  no
## 2864  2008-05-14      178        1    -1        0  unknown  no
## 2865  2008-05-14      452        2    -1        0  unknown  no
## 2866  2008-05-14      858        1    -1        0  unknown yes
## 2867  2008-05-14       87        1    -1        0  unknown  no
## 2868  2008-05-14       97        1    -1        0  unknown  no
## 2869  2008-05-14      116        1    -1        0  unknown  no
## 2870  2008-05-14      120        1    -1        0  unknown  no
## 2871  2008-05-14      629        2    -1        0  unknown yes
## 2872  2008-05-14      198        1    -1        0  unknown  no
## 2873  2008-05-14      262        1    -1        0  unknown  no
## 2874  2008-05-14      179        1    -1        0  unknown  no
## 2875  2008-05-14       35        1    -1        0  unknown  no
## 2876  2008-05-14      156        1    -1        0  unknown  no
## 2877  2008-05-14      201        1    -1        0  unknown  no
## 2878  2008-05-14      159        1    -1        0  unknown  no
## 2879  2008-05-14       68        1    -1        0  unknown  no
## 2880  2008-05-14       75        1    -1        0  unknown  no
## 2881  2008-05-14      229        1    -1        0  unknown  no
## 2882  2008-05-14      126        1    -1        0  unknown  no
## 2883  2008-05-14      704        1    -1        0  unknown yes
## 2884  2008-05-14      164        1    -1        0  unknown  no
## 2885  2008-05-14      339        1    -1        0  unknown  no
## 2886  2008-05-14      461        1    -1        0  unknown  no
## 2887  2008-05-14      188        1    -1        0  unknown  no
## 2888  2008-05-14      546        1    -1        0  unknown  no
## 2889  2008-05-14      171        1    -1        0  unknown  no
## 2890  2008-05-14      351        1    -1        0  unknown  no
## 2891  2008-05-14       94        4    -1        0  unknown  no
## 2892  2008-05-14      168        2    -1        0  unknown  no
## 2893  2008-05-14      429        1    -1        0  unknown  no
## 2894  2008-05-14      249        2    -1        0  unknown  no
## 2895  2008-05-14      568        1    -1        0  unknown  no
## 2896  2008-05-14      299        1    -1        0  unknown  no
## 2897  2008-05-14      282        1    -1        0  unknown  no
## 2898  2008-05-14      760        1    -1        0  unknown yes
## 2899  2008-05-14      211        1    -1        0  unknown  no
## 2900  2008-05-14       77        1    -1        0  unknown  no
## 2901  2008-05-14      283        1    -1        0  unknown  no
## 2902  2008-05-14      263        1    -1        0  unknown  no
## 2903  2008-05-14      189        1    -1        0  unknown  no
## 2904  2008-05-14       91        1    -1        0  unknown  no
## 2905  2008-05-14       32        1    -1        0  unknown  no
## 2906  2008-05-14      139        2    -1        0  unknown  no
## 2907  2008-05-14      347        1    -1        0  unknown  no
## 2908  2008-05-14      152        1    -1        0  unknown  no
## 2909  2008-05-14      869        1    -1        0  unknown  no
## 2910  2008-05-14      339        1    -1        0  unknown  no
## 2911  2008-05-14      267        1    -1        0  unknown  no
## 2912  2008-05-14       34        1    -1        0  unknown  no
## 2913  2008-05-14      153        2    -1        0  unknown  no
## 2914  2008-05-14       28        2    -1        0  unknown  no
## 2915  2008-05-14      216        1    -1        0  unknown  no
## 2916  2008-05-14      215        1    -1        0  unknown  no
## 2917  2008-05-14      199        2    -1        0  unknown  no
## 2918  2008-05-14      139        1    -1        0  unknown  no
## 2919  2008-05-14      322        1    -1        0  unknown  no
## 2920  2008-05-14      189        1    -1        0  unknown  no
## 2921  2008-05-14      197        2    -1        0  unknown  no
## 2922  2008-05-14      224        2    -1        0  unknown  no
## 2923  2008-05-14      160        1    -1        0  unknown  no
## 2924  2008-05-14      143        1    -1        0  unknown  no
## 2925  2008-05-14      191        1    -1        0  unknown  no
## 2926  2008-05-14      833        1    -1        0  unknown  no
## 2927  2008-05-14      356        1    -1        0  unknown  no
## 2928  2008-05-14      485        2    -1        0  unknown  no
## 2929  2008-05-14       57        1    -1        0  unknown  no
## 2930  2008-05-14      930        1    -1        0  unknown yes
## 2931  2008-05-14      247        2    -1        0  unknown  no
## 2932  2008-05-14      208        1    -1        0  unknown  no
## 2933  2008-05-14       89        1    -1        0  unknown  no
## 2934  2008-05-14       72        1    -1        0  unknown  no
## 2935  2008-05-14      260        1    -1        0  unknown  no
## 2936  2008-05-14      129        1    -1        0  unknown  no
## 2937  2008-05-14      151        2    -1        0  unknown  no
## 2938  2008-05-14      181        1    -1        0  unknown  no
## 2939  2008-05-14      125        1    -1        0  unknown  no
## 2940  2008-05-14      225        1    -1        0  unknown  no
## 2941  2008-05-14      829        1    -1        0  unknown  no
## 2942  2008-05-14      749        2    -1        0  unknown  no
## 2943  2008-05-14      166        2    -1        0  unknown  no
## 2944  2008-05-14       87        1    -1        0  unknown  no
## 2945  2008-05-14      407        2    -1        0  unknown  no
## 2946  2008-05-14      438        4    -1        0  unknown  no
## 2947  2008-05-14      387        2    -1        0  unknown  no
## 2948  2008-05-14      100        3    -1        0  unknown  no
## 2949  2008-05-14      413        2    -1        0  unknown  no
## 2950  2008-05-14      521        2    -1        0  unknown  no
## 2951  2008-05-14      133        1    -1        0  unknown  no
## 2952  2008-05-14      191        2    -1        0  unknown  no
## 2953  2008-05-14      521        2    -1        0  unknown  no
## 2954  2008-05-14      109        1    -1        0  unknown  no
## 2955  2008-05-14      345        2    -1        0  unknown  no
## 2956  2008-05-14     1028        2    -1        0  unknown yes
## 2957  2008-05-14      566        2    -1        0  unknown  no
## 2958  2008-05-14       38        1    -1        0  unknown  no
## 2959  2008-05-14      314        1    -1        0  unknown  no
## 2960  2008-05-14      214        1    -1        0  unknown  no
## 2961  2008-05-14      248        2    -1        0  unknown  no
## 2962  2008-05-14      246        1    -1        0  unknown  no
## 2963  2008-05-14      136        8    -1        0  unknown  no
## 2964  2008-05-14       98        1    -1        0  unknown  no
## 2965  2008-05-14      225        2    -1        0  unknown  no
## 2966  2008-05-14      364        1    -1        0  unknown  no
## 2967  2008-05-14      784        1    -1        0  unknown  no
## 2968  2008-05-14       93       14    -1        0  unknown  no
## 2969  2008-05-14       57        2    -1        0  unknown  no
## 2970  2008-05-14      160        2    -1        0  unknown  no
## 2971  2008-05-14      210        2    -1        0  unknown  no
## 2972  2008-05-14      222        2    -1        0  unknown  no
## 2973  2008-05-14       21       10    -1        0  unknown  no
## 2974  2008-05-14      222        5    -1        0  unknown  no
## 2975  2008-05-14      157        1    -1        0  unknown  no
## 2976  2008-05-14      143        1    -1        0  unknown  no
## 2977  2008-05-14      371        1    -1        0  unknown  no
## 2978  2008-05-14      161        2    -1        0  unknown  no
## 2979  2008-05-14      350        2    -1        0  unknown  no
## 2980  2008-05-14      135        1    -1        0  unknown  no
## 2981  2008-05-14      162        1    -1        0  unknown  no
## 2982  2008-05-14      565        1    -1        0  unknown  no
## 2983  2008-05-14      850        2    -1        0  unknown yes
## 2984  2008-05-14       44        8    -1        0  unknown  no
## 2985  2008-05-14      337        1    -1        0  unknown  no
## 2986  2008-05-14      416        2    -1        0  unknown  no
## 2987  2008-05-14      102        2    -1        0  unknown  no
## 2988  2008-05-14        5        2    -1        0  unknown  no
## 2989  2008-05-14      129        2    -1        0  unknown  no
## 2990  2008-05-14      977        1    -1        0  unknown  no
## 2991  2008-05-14      138        2    -1        0  unknown  no
## 2992  2008-05-14       70        2    -1        0  unknown  no
## 2993  2008-05-14       71        1    -1        0  unknown  no
## 2994  2008-05-14       75        1    -1        0  unknown  no
## 2995  2008-05-14      230        2    -1        0  unknown  no
## 2996  2008-05-14      369        1    -1        0  unknown  no
## 2997  2008-05-14      136        1    -1        0  unknown  no
## 2998  2008-05-14       22        4    -1        0  unknown  no
## 2999  2008-05-14      378        1    -1        0  unknown  no
## 3000  2008-05-14      240        1    -1        0  unknown  no
## 3001  2008-05-14       80        1    -1        0  unknown  no
## 3002  2008-05-14      144        1    -1        0  unknown  no
## 3003  2008-05-14      380        4    -1        0  unknown  no
## 3004  2008-05-14      108        1    -1        0  unknown  no
## 3005  2008-05-14      927        1    -1        0  unknown yes
## 3006  2008-05-14      389        1    -1        0  unknown  no
## 3007  2008-05-14      192        1    -1        0  unknown  no
## 3008  2008-05-14      273        1    -1        0  unknown  no
## 3009  2008-05-14       48        1    -1        0  unknown  no
## 3010  2008-05-14        8        1    -1        0  unknown  no
## 3011  2008-05-14      628        1    -1        0  unknown  no
## 3012  2008-05-14       90        1    -1        0  unknown  no
## 3013  2008-05-14      221        1    -1        0  unknown  no
## 3014  2008-05-14      217        1    -1        0  unknown  no
## 3015  2008-05-14      762        2    -1        0  unknown  no
## 3016  2008-05-14      193        2    -1        0  unknown  no
## 3017  2008-05-14      302        2    -1        0  unknown  no
## 3018  2008-05-14      411        1    -1        0  unknown  no
## 3019  2008-05-14      245        2    -1        0  unknown  no
## 3020  2008-05-14      746        1    -1        0  unknown  no
## 3021  2008-05-14      673        2    -1        0  unknown  no
## 3022  2008-05-14      220        7    -1        0  unknown  no
## 3023  2008-05-14      232        1    -1        0  unknown  no
## 3024  2008-05-14      115        3    -1        0  unknown  no
## 3025  2008-05-14      485        2    -1        0  unknown  no
## 3026  2008-05-14      106        5    -1        0  unknown  no
## 3027  2008-05-14      107        1    -1        0  unknown  no
## 3028  2008-05-14     1044        2    -1        0  unknown  no
## 3029  2008-05-14      180        4    -1        0  unknown  no
## 3030  2008-05-14      354        1    -1        0  unknown  no
## 3031  2008-05-14       55        1    -1        0  unknown  no
## 3032  2008-05-14      392        1    -1        0  unknown  no
## 3033  2008-05-14      123        1    -1        0  unknown  no
## 3034  2008-05-14      148        3    -1        0  unknown  no
## 3035  2008-05-14       74        3    -1        0  unknown  no
## 3036  2008-05-14      267        8    -1        0  unknown  no
## 3037  2008-05-14      374        2    -1        0  unknown  no
## 3038  2008-05-14      295        2    -1        0  unknown  no
## 3039  2008-05-14      149        2    -1        0  unknown  no
## 3040  2008-05-14      226        2    -1        0  unknown  no
## 3041  2008-05-14      668        1    -1        0  unknown  no
## 3042  2008-05-14       95        6    -1        0  unknown  no
## 3043  2008-05-14      229        2    -1        0  unknown  no
## 3044  2008-05-14      252        3    -1        0  unknown  no
## 3045  2008-05-14      286       14    -1        0  unknown  no
## 3046  2008-05-14      242        5    -1        0  unknown  no
## 3047  2008-05-14      335        1    -1        0  unknown  no
## 3048  2008-05-14      323        5    -1        0  unknown  no
## 3049  2008-05-14      140        1    -1        0  unknown  no
## 3050  2008-05-14      159        3    -1        0  unknown  no
## 3051  2008-05-14      293        3    -1        0  unknown  no
## 3052  2008-05-14       85        4    -1        0  unknown  no
## 3053  2008-05-14      343        1    -1        0  unknown  no
## 3054  2008-05-14      295        1    -1        0  unknown  no
## 3055  2008-05-14      360        1    -1        0  unknown  no
## 3056  2008-05-14      183        4    -1        0  unknown  no
## 3057  2008-05-14      304        3    -1        0  unknown  no
## 3058  2008-05-14      382       10    -1        0  unknown  no
## 3059  2008-05-14      514        2    -1        0  unknown  no
## 3060  2008-05-14      142        3    -1        0  unknown  no
## 3061  2008-05-14      162        2    -1        0  unknown  no
## 3062  2008-05-14      301        3    -1        0  unknown  no
## 3063  2008-05-14      264        2    -1        0  unknown  no
## 3064  2008-05-14      150        1    -1        0  unknown  no
## 3065  2008-05-14       49        1    -1        0  unknown  no
## 3066  2008-05-14      326        3    -1        0  unknown  no
## 3067  2008-05-14      468        2    -1        0  unknown  no
## 3068  2008-05-14      183        2    -1        0  unknown  no
## 3069  2008-05-14      339        1    -1        0  unknown  no
## 3070  2008-05-14      125        1    -1        0  unknown  no
## 3071  2008-05-14      232        2    -1        0  unknown  no
## 3072  2008-05-14      312        5    -1        0  unknown  no
## 3073  2008-05-14      423        2    -1        0  unknown  no
## 3074  2008-05-14      163        1    -1        0  unknown  no
## 3075  2008-05-14      191        1    -1        0  unknown  no
## 3076  2008-05-14      248        1    -1        0  unknown  no
## 3077  2008-05-14      146        1    -1        0  unknown  no
## 3078  2008-05-14      125        2    -1        0  unknown  no
## 3079  2008-05-14      234        1    -1        0  unknown  no
## 3080  2008-05-14       17       24    -1        0  unknown  no
## 3081  2008-05-14      546        1    -1        0  unknown  no
## 3082  2008-05-14      554        1    -1        0  unknown  no
## 3083  2008-05-14      162        4    -1        0  unknown  no
## 3084  2008-05-14      436        1    -1        0  unknown  no
## 3085  2008-05-14      297        2    -1        0  unknown  no
## 3086  2008-05-14      302        2    -1        0  unknown  no
## 3087  2008-05-14      349        5    -1        0  unknown  no
## 3088  2008-05-14      174        2    -1        0  unknown  no
## 3089  2008-05-14      180        1    -1        0  unknown  no
## 3090  2008-05-14      902        5    -1        0  unknown  no
## 3091  2008-05-14      137        2    -1        0  unknown  no
## 3092  2008-05-14      282        1    -1        0  unknown  no
## 3093  2008-05-14      321        1    -1        0  unknown  no
## 3094  2008-05-14      126        3    -1        0  unknown  no
## 3095  2008-05-14      554        1    -1        0  unknown  no
## 3096  2008-05-14       21       11    -1        0  unknown  no
## 3097  2008-05-14      427        1    -1        0  unknown  no
## 3098  2008-05-14       97        5    -1        0  unknown  no
## 3099  2008-05-14      402        1    -1        0  unknown  no
## 3100  2008-05-14      252        2    -1        0  unknown  no
## 3101  2008-05-14      449        2    -1        0  unknown  no
## 3102  2008-05-14      360        2    -1        0  unknown  no
## 3103  2008-05-14       89        7    -1        0  unknown  no
## 3104  2008-05-14      241        2    -1        0  unknown  no
## 3105  2008-05-14      574        2    -1        0  unknown  no
## 3106  2008-05-14      274        2    -1        0  unknown  no
## 3107  2008-05-14      154        2    -1        0  unknown  no
## 3108  2008-05-14       71        4    -1        0  unknown  no
## 3109  2008-05-14      122        4    -1        0  unknown  no
## 3110  2008-05-14      166        4    -1        0  unknown  no
## 3111  2008-05-14      163        5    -1        0  unknown  no
## 3112  2008-05-14      167        3    -1        0  unknown  no
## 3113  2008-05-14       91        7    -1        0  unknown  no
## 3114  2008-05-14      133        4    -1        0  unknown  no
## 3115  2008-05-14      594        2    -1        0  unknown  no
## 3116  2008-05-14       86        2    -1        0  unknown  no
## 3117  2008-05-14       40        2    -1        0  unknown  no
## 3118  2008-05-14      166        3    -1        0  unknown  no
## 3119  2008-05-14      302       16    -1        0  unknown  no
## 3120  2008-05-14      303        4    -1        0  unknown  no
## 3121  2008-05-14      636        6    -1        0  unknown  no
## 3122  2008-05-14      341        5    -1        0  unknown  no
## 3123  2008-05-14      483        3    -1        0  unknown  no
## 3124  2008-05-14      220        2    -1        0  unknown  no
## 3125  2008-05-14      234        2    -1        0  unknown  no
## 3126  2008-05-14       32        3    -1        0  unknown  no
## 3127  2008-05-14      211        3    -1        0  unknown  no
## 3128  2008-05-14      738        2    -1        0  unknown  no
## 3129  2008-05-14      482        2    -1        0  unknown  no
## 3130  2008-05-14      238        2    -1        0  unknown  no
## 3131  2008-05-14      370        2    -1        0  unknown  no
## 3132  2008-05-14       76        2    -1        0  unknown  no
## 3133  2008-05-14      225        2    -1        0  unknown  no
## 3134  2008-05-14      256        2    -1        0  unknown  no
## 3135  2008-05-14      567        3    -1        0  unknown  no
## 3136  2008-05-14     2241        4    -1        0  unknown  no
## 3137  2008-05-14      147        3    -1        0  unknown  no
## 3138  2008-05-14      135        2    -1        0  unknown  no
## 3139  2008-05-14      260        2    -1        0  unknown  no
## 3140  2008-05-14      254        2    -1        0  unknown  no
## 3141  2008-05-14     1118        2    -1        0  unknown  no
## 3142  2008-05-14       76        9    -1        0  unknown  no
## 3143  2008-05-14       79        3    -1        0  unknown  no
## 3144  2008-05-14       94        6    -1        0  unknown  no
## 3145  2008-05-14      208        5    -1        0  unknown  no
## 3146  2008-05-14     1423        3    -1        0  unknown yes
## 3147  2008-05-14      271        2    -1        0  unknown  no
## 3148  2008-05-14      166        5    -1        0  unknown  no
## 3149  2008-05-14      256        4    -1        0  unknown  no
## 3150  2008-05-14       19       14    -1        0  unknown  no
## 3151  2008-05-14      173       11    -1        0  unknown  no
## 3152  2008-05-14      367        3    -1        0  unknown  no
## 3153  2008-05-14      414        2    -1        0  unknown  no
## 3154  2008-05-14      227        4    -1        0  unknown  no
## 3155  2008-05-14      349        2    -1        0  unknown  no
## 3156  2008-05-14      278        2    -1        0  unknown  no
## 3157  2008-05-14      103        5    -1        0  unknown  no
## 3158  2008-05-14      249        2    -1        0  unknown  no
## 3159  2008-05-14      143        3    -1        0  unknown  no
## 3160  2008-05-14       37        3    -1        0  unknown  no
## 3161  2008-05-14      168        3    -1        0  unknown  no
## 3162  2008-05-14      260        3    -1        0  unknown  no
## 3163  2008-05-14      162        3    -1        0  unknown  no
## 3164  2008-05-14      187        3    -1        0  unknown  no
## 3165  2008-05-14      266        2    -1        0  unknown  no
## 3166  2008-05-14      279        2    -1        0  unknown  no
## 3167  2008-05-14      159        2    -1        0  unknown  no
## 3168  2008-05-14      318        2    -1        0  unknown  no
## 3169  2008-05-14      104        3    -1        0  unknown  no
## 3170  2008-05-14      747        3    -1        0  unknown  no
## 3171  2008-05-14     1204        4    -1        0  unknown  no
## 3172  2008-05-15       95        4    -1        0  unknown  no
## 3173  2008-05-15      176        2    -1        0  unknown  no
## 3174  2008-05-15      179        2    -1        0  unknown  no
## 3175  2008-05-15      319        5    -1        0  unknown  no
## 3176  2008-05-15      114        2    -1        0  unknown  no
## 3177  2008-05-15      170        5    -1        0  unknown  no
## 3178  2008-05-15      311        5    -1        0  unknown  no
## 3179  2008-05-15      362        3    -1        0  unknown  no
## 3180  2008-05-15      347        8    -1        0  unknown  no
## 3181  2008-05-15       86        4    -1        0  unknown  no
## 3182  2008-05-15      101        4    -1        0  unknown  no
## 3183  2008-05-15      288        2    -1        0  unknown  no
## 3184  2008-05-15       44        3    -1        0  unknown  no
## 3185  2008-05-15     1013        3    -1        0  unknown  no
## 3186  2008-05-15       90        3    -1        0  unknown  no
## 3187  2008-05-15      155        6    -1        0  unknown  no
## 3188  2008-05-15      468        5    -1        0  unknown  no
## 3189  2008-05-15      226        2    -1        0  unknown  no
## 3190  2008-05-15       54        2    -1        0  unknown  no
## 3191  2008-05-15     1162        4    -1        0  unknown yes
## 3192  2008-05-15      114        2    -1        0  unknown  no
## 3193  2008-05-15      349        2    -1        0  unknown  no
## 3194  2008-05-15      646        3    -1        0  unknown yes
## 3195  2008-05-15      755        2    -1        0  unknown  no
## 3196  2008-05-15      305        3    -1        0  unknown  no
## 3197  2008-05-15      148        3    -1        0  unknown  no
## 3198  2008-05-15      243        1    -1        0  unknown  no
## 3199  2008-05-15      391        2    -1        0  unknown  no
## 3200  2008-05-15      204        1    -1        0  unknown  no
## 3201  2008-05-15      236        4    -1        0  unknown  no
## 3202  2008-05-15      112        1    -1        0  unknown  no
## 3203  2008-05-15      125        4    -1        0  unknown  no
## 3204  2008-05-15      141        1    -1        0  unknown  no
## 3205  2008-05-15      360        1    -1        0  unknown  no
## 3206  2008-05-15      312        6    -1        0  unknown  no
## 3207  2008-05-15      366        1    -1        0  unknown  no
## 3208  2008-05-15      100        1    -1        0  unknown  no
## 3209  2008-05-15       70        1    -1        0  unknown  no
## 3210  2008-05-15      254        1    -1        0  unknown  no
## 3211  2008-05-15      230        1    -1        0  unknown  no
## 3212  2008-05-15      246        1    -1        0  unknown  no
## 3213  2008-05-15       97        1    -1        0  unknown  no
## 3214  2008-05-15      135        1    -1        0  unknown  no
## 3215  2008-05-15      755        1    -1        0  unknown yes
## 3216  2008-05-15       73        1    -1        0  unknown  no
## 3217  2008-05-15       12        3    -1        0  unknown  no
## 3218  2008-05-15       65        1    -1        0  unknown  no
## 3219  2008-05-15      420        1    -1        0  unknown  no
## 3220  2008-05-15      259        1    -1        0  unknown  no
## 3221  2008-05-15      192        1    -1        0  unknown  no
## 3222  2008-05-15      189        1    -1        0  unknown  no
## 3223  2008-05-15      263        1    -1        0  unknown  no
## 3224  2008-05-15      126        1    -1        0  unknown  no
## 3225  2008-05-15      415        8    -1        0  unknown  no
## 3226  2008-05-15      746        1    -1        0  unknown yes
## 3227  2008-05-15      260        1    -1        0  unknown  no
## 3228  2008-05-15       71        1    -1        0  unknown  no
## 3229  2008-05-15      735        1    -1        0  unknown  no
## 3230  2008-05-15       75        1    -1        0  unknown  no
## 3231  2008-05-15       87        1    -1        0  unknown  no
## 3232  2008-05-15      183        5    -1        0  unknown  no
## 3233  2008-05-15       62        1    -1        0  unknown  no
## 3234  2008-05-15      150        1    -1        0  unknown  no
## 3235  2008-05-15      244        1    -1        0  unknown  no
## 3236  2008-05-15      367        2    -1        0  unknown  no
## 3237  2008-05-15      325        1    -1        0  unknown  no
## 3238  2008-05-15      197        1    -1        0  unknown  no
## 3239  2008-05-15      121        1    -1        0  unknown  no
## 3240  2008-05-15       27        1    -1        0  unknown  no
## 3241  2008-05-15      157        1    -1        0  unknown  no
## 3242  2008-05-15      203        1    -1        0  unknown  no
## 3243  2008-05-15      115        1    -1        0  unknown  no
## 3244  2008-05-15      112        1    -1        0  unknown  no
## 3245  2008-05-15      104        1    -1        0  unknown  no
## 3246  2008-05-15      153        1    -1        0  unknown  no
## 3247  2008-05-15      182        2    -1        0  unknown  no
## 3248  2008-05-15       55        1    -1        0  unknown  no
## 3249  2008-05-15      305        1    -1        0  unknown  no
## 3250  2008-05-15      140        1    -1        0  unknown  no
## 3251  2008-05-15      180        2    -1        0  unknown  no
## 3252  2008-05-15      644        2    -1        0  unknown  no
## 3253  2008-05-15      173        1    -1        0  unknown  no
## 3254  2008-05-15      374        1    -1        0  unknown  no
## 3255  2008-05-15      240        1    -1        0  unknown  no
## 3256  2008-05-15     1088        2    -1        0  unknown  no
## 3257  2008-05-15      219        1    -1        0  unknown  no
## 3258  2008-05-15       41        1    -1        0  unknown  no
## 3259  2008-05-15      558        6    -1        0  unknown  no
## 3260  2008-05-15      436        1    -1        0  unknown  no
## 3261  2008-05-15      463        1    -1        0  unknown  no
## 3262  2008-05-15      265        1    -1        0  unknown  no
## 3263  2008-05-15      234        1    -1        0  unknown  no
## 3264  2008-05-15      113        1    -1        0  unknown  no
## 3265  2008-05-15      200        1    -1        0  unknown  no
## 3266  2008-05-15      158        1    -1        0  unknown  no
## 3267  2008-05-15       34        1    -1        0  unknown  no
## 3268  2008-05-15      160        1    -1        0  unknown  no
## 3269  2008-05-15      167        1    -1        0  unknown  no
## 3270  2008-05-15      206        1    -1        0  unknown  no
## 3271  2008-05-15       36        1    -1        0  unknown  no
## 3272  2008-05-15      504        3    -1        0  unknown  no
## 3273  2008-05-15      303        1    -1        0  unknown  no
## 3274  2008-05-15      109        1    -1        0  unknown  no
## 3275  2008-05-15       90        1    -1        0  unknown  no
## 3276  2008-05-15      139        2    -1        0  unknown  no
## 3277  2008-05-15      257        1    -1        0  unknown  no
## 3278  2008-05-15      241        2    -1        0  unknown  no
## 3279  2008-05-15       94        1    -1        0  unknown  no
## 3280  2008-05-15      171       10    -1        0  unknown  no
## 3281  2008-05-15      178        1    -1        0  unknown  no
## 3282  2008-05-15      285        2    -1        0  unknown  no
## 3283  2008-05-15       86        1    -1        0  unknown  no
## 3284  2008-05-15      326        4    -1        0  unknown  no
## 3285  2008-05-15      451        2    -1        0  unknown  no
## 3286  2008-05-15      347        1    -1        0  unknown  no
## 3287  2008-05-15      116        1    -1        0  unknown  no
## 3288  2008-05-15      191        1    -1        0  unknown  no
## 3289  2008-05-15       77        1    -1        0  unknown  no
## 3290  2008-05-15     1036        1    -1        0  unknown  no
## 3291  2008-05-15      303        1    -1        0  unknown  no
## 3292  2008-05-15       80        1    -1        0  unknown  no
## 3293  2008-05-15      322        1    -1        0  unknown  no
## 3294  2008-05-15      750        2    -1        0  unknown  no
## 3295  2008-05-15      695        1    -1        0  unknown yes
## 3296  2008-05-15      435        1    -1        0  unknown  no
## 3297  2008-05-15      397        1    -1        0  unknown  no
## 3298  2008-05-15       95        3    -1        0  unknown  no
## 3299  2008-05-15      208        2    -1        0  unknown  no
## 3300  2008-05-15      163        1    -1        0  unknown  no
## 3301  2008-05-15      483        1    -1        0  unknown yes
## 3302  2008-05-15      168        5    -1        0  unknown  no
## 3303  2008-05-15      161        3    -1        0  unknown  no
## 3304  2008-05-15     1000        1    -1        0  unknown  no
## 3305  2008-05-15      112        1    -1        0  unknown  no
## 3306  2008-05-15      599        2    -1        0  unknown  no
## 3307  2008-05-15       30        1    -1        0  unknown  no
## 3308  2008-05-15       58        5    -1        0  unknown  no
## 3309  2008-05-15      165        1    -1        0  unknown  no
## 3310  2008-05-15       74        1    -1        0  unknown  no
## 3311  2008-05-15       79        1    -1        0  unknown  no
## 3312  2008-05-15      231        1    -1        0  unknown  no
## 3313  2008-05-15      191        1    -1        0  unknown  no
## 3314  2008-05-15      202        3    -1        0  unknown  no
## 3315  2008-05-15     1257        3    -1        0  unknown yes
## 3316  2008-05-15      221        1    -1        0  unknown  no
## 3317  2008-05-15      257        1    -1        0  unknown  no
## 3318  2008-05-15      352        1    -1        0  unknown  no
## 3319  2008-05-15      285        1    -1        0  unknown  no
## 3320  2008-05-15       93        1    -1        0  unknown  no
## 3321  2008-05-15       71        2    -1        0  unknown  no
## 3322  2008-05-15      290        3    -1        0  unknown  no
## 3323  2008-05-15     1165        1    -1        0  unknown  no
## 3324  2008-05-15      164        1    -1        0  unknown  no
## 3325  2008-05-15      520        2    -1        0  unknown yes
## 3326  2008-05-15      295        2    -1        0  unknown  no
## 3327  2008-05-15      187        1    -1        0  unknown  no
## 3328  2008-05-15      106        1    -1        0  unknown  no
## 3329  2008-05-15      219        1    -1        0  unknown  no
## 3330  2008-05-15      236        1    -1        0  unknown  no
## 3331  2008-05-15      139        1    -1        0  unknown  no
## 3332  2008-05-15      651       32    -1        0  unknown yes
## 3333  2008-05-15      124        1    -1        0  unknown  no
## 3334  2008-05-15       98        3    -1        0  unknown  no
## 3335  2008-05-15      145        4    -1        0  unknown  no
## 3336  2008-05-15      120        1    -1        0  unknown  no
## 3337  2008-05-15      291        2    -1        0  unknown  no
## 3338  2008-05-15      101        1    -1        0  unknown  no
## 3339  2008-05-15      417        3    -1        0  unknown  no
## 3340  2008-05-15      191        4    -1        0  unknown  no
## 3341  2008-05-15      131        1    -1        0  unknown  no
## 3342  2008-05-15      221        2    -1        0  unknown  no
## 3343  2008-05-15      229        1    -1        0  unknown  no
## 3344  2008-05-15      104        1    -1        0  unknown  no
## 3345  2008-05-15       72        1    -1        0  unknown  no
## 3346  2008-05-15      186        1    -1        0  unknown  no
## 3347  2008-05-15       23        1    -1        0  unknown  no
## 3348  2008-05-15      402        1    -1        0  unknown  no
## 3349  2008-05-15       37        1    -1        0  unknown  no
## 3350  2008-05-15       68        5    -1        0  unknown  no
## 3351  2008-05-15      182        1    -1        0  unknown  no
## 3352  2008-05-15      587        1    -1        0  unknown  no
## 3353  2008-05-15      348        1    -1        0  unknown  no
## 3354  2008-05-15      140        1    -1        0  unknown  no
## 3355  2008-05-15       51        2    -1        0  unknown  no
## 3356  2008-05-15      176       18    -1        0  unknown  no
## 3357  2008-05-15      144        2    -1        0  unknown  no
## 3358  2008-05-15      297        3    -1        0  unknown  no
## 3359  2008-05-15      203        2    -1        0  unknown  no
## 3360  2008-05-15       57        2    -1        0  unknown  no
## 3361  2008-05-15      334        3    -1        0  unknown  no
## 3362  2008-05-15      217        2    -1        0  unknown  no
## 3363  2008-05-15       74        1    -1        0  unknown  no
## 3364  2008-05-15      405        2    -1        0  unknown  no
## 3365  2008-05-15      738        7    -1        0  unknown  no
## 3366  2008-05-15      452        2    -1        0  unknown  no
## 3367  2008-05-15      203        4    -1        0  unknown  no
## 3368  2008-05-15      230        7    -1        0  unknown  no
## 3369  2008-05-15      133        3    -1        0  unknown  no
## 3370  2008-05-15       94        1    -1        0  unknown  no
## 3371  2008-05-15      187        6    -1        0  unknown  no
## 3372  2008-05-15      920        2    -1        0  unknown yes
## 3373  2008-05-15      136        1    -1        0  unknown  no
## 3374  2008-05-15     1244        3    -1        0  unknown  no
## 3375  2008-05-15      225        1    -1        0  unknown  no
## 3376  2008-05-15       80        1    -1        0  unknown  no
## 3377  2008-05-15      431        1    -1        0  unknown  no
## 3378  2008-05-15       78        1    -1        0  unknown  no
## 3379  2008-05-15      500        1    -1        0  unknown yes
## 3380  2008-05-15      301        1    -1        0  unknown  no
## 3381  2008-05-15       30        1    -1        0  unknown  no
## 3382  2008-05-15      133        1    -1        0  unknown  no
## 3383  2008-05-15      270        1    -1        0  unknown  no
## 3384  2008-05-15      218        2    -1        0  unknown  no
## 3385  2008-05-15      215        2    -1        0  unknown  no
## 3386  2008-05-15      299        1    -1        0  unknown  no
## 3387  2008-05-15      160        1    -1        0  unknown  no
## 3388  2008-05-15      172        4    -1        0  unknown  no
## 3389  2008-05-15       49        1    -1        0  unknown  no
## 3390  2008-05-15       68        2    -1        0  unknown  no
## 3391  2008-05-15      117        1    -1        0  unknown  no
## 3392  2008-05-15      477        1    -1        0  unknown  no
## 3393  2008-05-15       99        1    -1        0  unknown  no
## 3394  2008-05-15      100        1    -1        0  unknown  no
## 3395  2008-05-15      200        3    -1        0  unknown  no
## 3396  2008-05-15      187        2    -1        0  unknown  no
## 3397  2008-05-15      236        3    -1        0  unknown  no
## 3398  2008-05-15       50        7    -1        0  unknown  no
## 3399  2008-05-15      104        2    -1        0  unknown  no
## 3400  2008-05-15       51       10    -1        0  unknown  no
## 3401  2008-05-15       51        5    -1        0  unknown  no
## 3402  2008-05-15      140        3    -1        0  unknown  no
## 3403  2008-05-15      221        4    -1        0  unknown  no
## 3404  2008-05-15       98        2    -1        0  unknown  no
## 3405  2008-05-15      253        2    -1        0  unknown  no
## 3406  2008-05-15       71        1    -1        0  unknown  no
## 3407  2008-05-15      127        2    -1        0  unknown  no
## 3408  2008-05-15       74        2    -1        0  unknown  no
## 3409  2008-05-15      126        4    -1        0  unknown  no
## 3410  2008-05-15      122        1    -1        0  unknown  no
## 3411  2008-05-15      657        5    -1        0  unknown  no
## 3412  2008-05-15      173        2    -1        0  unknown  no
## 3413  2008-05-15      918        1    -1        0  unknown  no
## 3414  2008-05-15      544        2    -1        0  unknown  no
## 3415  2008-05-15      309        2    -1        0  unknown  no
## 3416  2008-05-15      138        2    -1        0  unknown  no
## 3417  2008-05-15       73        1    -1        0  unknown  no
## 3418  2008-05-15       71        2    -1        0  unknown  no
## 3419  2008-05-15       29        1    -1        0  unknown  no
## 3420  2008-05-15      193        5    -1        0  unknown  no
## 3421  2008-05-15      198        3    -1        0  unknown  no
## 3422  2008-05-15       57        2    -1        0  unknown  no
## 3423  2008-05-15       49        1    -1        0  unknown  no
## 3424  2008-05-15      197        4    -1        0  unknown  no
## 3425  2008-05-15       98        1    -1        0  unknown  no
## 3426  2008-05-15       59        1    -1        0  unknown  no
## 3427  2008-05-15      196        2    -1        0  unknown  no
## 3428  2008-05-15      243        1    -1        0  unknown  no
## 3429  2008-05-15      344        2    -1        0  unknown  no
## 3430  2008-05-15      570        2    -1        0  unknown  no
## 3431  2008-05-15      597        1    -1        0  unknown  no
## 3432  2008-05-15       43        9    -1        0  unknown  no
## 3433  2008-05-15      525        1    -1        0  unknown  no
## 3434  2008-05-15      759        1    -1        0  unknown  no
## 3435  2008-05-15      147        1    -1        0  unknown  no
## 3436  2008-05-15      236        1    -1        0  unknown  no
## 3437  2008-05-15      122        6    -1        0  unknown  no
## 3438  2008-05-15      152        2    -1        0  unknown  no
## 3439  2008-05-15      133        2    -1        0  unknown  no
## 3440  2008-05-15      504        5    -1        0  unknown  no
## 3441  2008-05-15      272        9    -1        0  unknown  no
## 3442  2008-05-15      164        2    -1        0  unknown  no
## 3443  2008-05-15       51        1    -1        0  unknown  no
## 3444  2008-05-15       75        2    -1        0  unknown  no
## 3445  2008-05-15      178        1    -1        0  unknown  no
## 3446  2008-05-15       99        2    -1        0  unknown  no
## 3447  2008-05-15      224        1    -1        0  unknown  no
## 3448  2008-05-15       34        1    -1        0  unknown  no
## 3449  2008-05-15      236        3    -1        0  unknown  no
## 3450  2008-05-15      815        1    -1        0  unknown  no
## 3451  2008-05-15      282        1    -1        0  unknown  no
## 3452  2008-05-15      134        1    -1        0  unknown  no
## 3453  2008-05-15      318        1    -1        0  unknown  no
## 3454  2008-05-15      118        1    -1        0  unknown  no
## 3455  2008-05-15      911        2    -1        0  unknown yes
## 3456  2008-05-15      238        1    -1        0  unknown  no
## 3457  2008-05-15      225        1    -1        0  unknown  no
## 3458  2008-05-15      490        3    -1        0  unknown  no
## 3459  2008-05-15      644        1    -1        0  unknown  no
## 3460  2008-05-15       76        3    -1        0  unknown  no
## 3461  2008-05-15      286        2    -1        0  unknown  no
## 3462  2008-05-15      176        2    -1        0  unknown  no
## 3463  2008-05-15      422        3    -1        0  unknown  no
## 3464  2008-05-15      328        1    -1        0  unknown  no
## 3465  2008-05-15       22        3    -1        0  unknown  no
## 3466  2008-05-15       71        4    -1        0  unknown  no
## 3467  2008-05-15      106        3    -1        0  unknown  no
## 3468  2008-05-15      465        3    -1        0  unknown  no
## 3469  2008-05-15      973        2    -1        0  unknown  no
## 3470  2008-05-15       56        1    -1        0  unknown  no
## 3471  2008-05-15      190        2    -1        0  unknown  no
## 3472  2008-05-15      323        1    -1        0  unknown  no
## 3473  2008-05-15      113        1    -1        0  unknown  no
## 3474  2008-05-15      228        1    -1        0  unknown  no
## 3475  2008-05-15      110        1    -1        0  unknown  no
## 3476  2008-05-15       84       22    -1        0  unknown  no
## 3477  2008-05-15       59        1    -1        0  unknown  no
## 3478  2008-05-15      294        2    -1        0  unknown  no
## 3479  2008-05-15      144        1    -1        0  unknown  no
## 3480  2008-05-15      251        1    -1        0  unknown  no
## 3481  2008-05-15      444        1    -1        0  unknown  no
## 3482  2008-05-15      237        2    -1        0  unknown  no
## 3483  2008-05-15      399        1    -1        0  unknown  no
## 3484  2008-05-15      132       32    -1        0  unknown  no
## 3485  2008-05-15      995        2    -1        0  unknown  no
## 3486  2008-05-15      334       10    -1        0  unknown  no
## 3487  2008-05-15       59        2    -1        0  unknown  no
## 3488  2008-05-15      579        1    -1        0  unknown  no
## 3489  2008-05-15      387        4    -1        0  unknown  no
## 3490  2008-05-15      279        9    -1        0  unknown  no
## 3491  2008-05-15      352        2    -1        0  unknown  no
## 3492  2008-05-15      484       11    -1        0  unknown  no
## 3493  2008-05-15       95        1    -1        0  unknown  no
## 3494  2008-05-15      461        1    -1        0  unknown  no
## 3495  2008-05-15       30        2    -1        0  unknown  no
## 3496  2008-05-15      561        1    -1        0  unknown  no
## 3497  2008-05-15      468        2    -1        0  unknown  no
## 3498  2008-05-15      920        2    -1        0  unknown yes
## 3499  2008-05-15      388        2    -1        0  unknown  no
## 3500  2008-05-15      100        4    -1        0  unknown  no
## 3501  2008-05-15     1224        2    -1        0  unknown yes
## 3502  2008-05-15      589        1    -1        0  unknown  no
## 3503  2008-05-15      160        1    -1        0  unknown  no
## 3504  2008-05-15      438        2    -1        0  unknown  no
## 3505  2008-05-15      964        2    -1        0  unknown  no
## 3506  2008-05-15      384        4    -1        0  unknown  no
## 3507  2008-05-15      103        1    -1        0  unknown  no
## 3508  2008-05-15       52        1    -1        0  unknown  no
## 3509  2008-05-15      205        2    -1        0  unknown  no
## 3510  2008-05-15     1156        2    -1        0  unknown yes
## 3511  2008-05-15       73        2    -1        0  unknown  no
## 3512  2008-05-15      157        5    -1        0  unknown  no
## 3513  2008-05-15      186        5    -1        0  unknown  no
## 3514  2008-05-15       73        5    -1        0  unknown  no
## 3515  2008-05-15      714        4    -1        0  unknown  no
## 3516  2008-05-15      544        3    -1        0  unknown  no
## 3517  2008-05-15      194        2    -1        0  unknown  no
## 3518  2008-05-15      420        4    -1        0  unknown  no
## 3519  2008-05-15      584        2    -1        0  unknown  no
## 3520  2008-05-15     1052        1    -1        0  unknown yes
## 3521  2008-05-15      192        3    -1        0  unknown  no
## 3522  2008-05-15      155        2    -1        0  unknown  no
## 3523  2008-05-15      226        6    -1        0  unknown  no
## 3524  2008-05-15     1231        2    -1        0  unknown  no
## 3525  2008-05-15      619        4    -1        0  unknown  no
## 3526  2008-05-15      298        3    -1        0  unknown  no
## 3527  2008-05-15       21        6    -1        0  unknown  no
## 3528  2008-05-15      401        7    -1        0  unknown  no
## 3529  2008-05-15      404        7    -1        0  unknown  no
## 3530  2008-05-15      241       32    -1        0  unknown  no
## 3531  2008-05-15      302        1    -1        0  unknown  no
## 3532  2008-05-15      440        2    -1        0  unknown  no
## 3533  2008-05-15      172        2    -1        0  unknown  no
## 3534  2008-05-15      319        7    -1        0  unknown  no
## 3535  2008-05-15     1051        3    -1        0  unknown  no
## 3536  2008-05-15      276        3    -1        0  unknown  no
## 3537  2008-05-15      213        4    -1        0  unknown  no
## 3538  2008-05-15      276        4    -1        0  unknown  no
## 3539  2008-05-15      194        2    -1        0  unknown  no
## 3540  2008-05-15     1392        4    -1        0  unknown  no
## 3541  2008-05-15       19        8    -1        0  unknown  no
## 3542  2008-05-15      146        4    -1        0  unknown  no
## 3543  2008-05-15      253        2    -1        0  unknown  no
## 3544  2008-05-15      226        2    -1        0  unknown  no
## 3545  2008-05-15       57        4    -1        0  unknown  no
## 3546  2008-05-15      419        2    -1        0  unknown  no
## 3547  2008-05-15      546        9    -1        0  unknown  no
## 3548  2008-05-15      150        2    -1        0  unknown  no
## 3549  2008-05-15     1867        6    -1        0  unknown yes
## 3550  2008-05-15      156        5    -1        0  unknown  no
## 3551  2008-05-15      184        2    -1        0  unknown  no
## 3552  2008-05-15      548        1    -1        0  unknown  no
## 3553  2008-05-15      244        2    -1        0  unknown  no
## 3554  2008-05-15      328        4    -1        0  unknown  no
## 3555  2008-05-15      171        2    -1        0  unknown  no
## 3556  2008-05-15      284        5    -1        0  unknown  no
## 3557  2008-05-15       75        8    -1        0  unknown  no
## 3558  2008-05-15     1263        2    -1        0  unknown yes
## 3559  2008-05-15       92        3    -1        0  unknown  no
## 3560  2008-05-15      422        2    -1        0  unknown  no
## 3561  2008-05-15       17       10    -1        0  unknown  no
## 3562  2008-05-15      301        4    -1        0  unknown  no
## 3563  2008-05-15      267        5    -1        0  unknown  no
## 3564  2008-05-15      475        2    -1        0  unknown  no
## 3565  2008-05-15      770        2    -1        0  unknown  no
## 3566  2008-05-15      487        4    -1        0  unknown  no
## 3567  2008-05-15      126        2    -1        0  unknown  no
## 3568  2008-05-15      129        1    -1        0  unknown  no
## 3569  2008-05-15      257        7    -1        0  unknown  no
## 3570  2008-05-15      233        3    -1        0  unknown  no
## 3571  2008-05-15      365        1    -1        0  unknown  no
## 3572  2008-05-15      697        3    -1        0  unknown yes
## 3573  2008-05-15      192        3    -1        0  unknown  no
## 3574  2008-05-15      244        2    -1        0  unknown  no
## 3575  2008-05-15      118        4    -1        0  unknown  no
## 3576  2008-05-15      101        3    -1        0  unknown  no
## 3577  2008-05-15      125        5    -1        0  unknown  no
## 3578  2008-05-15       56       13    -1        0  unknown  no
## 3579  2008-05-15      430        2    -1        0  unknown  no
## 3580  2008-05-15      242        6    -1        0  unknown  no
## 3581  2008-05-15      809        3    -1        0  unknown  no
## 3582  2008-05-15      317        7    -1        0  unknown  no
## 3583  2008-05-15        7        9    -1        0  unknown  no
## 3584  2008-05-15      493        2    -1        0  unknown  no
## 3585  2008-05-15      381        7    -1        0  unknown  no
## 3586  2008-05-15      523        2    -1        0  unknown  no
## 3587  2008-05-15      112        2    -1        0  unknown  no
## 3588  2008-05-15      309        2    -1        0  unknown  no
## 3589  2008-05-15      184        2    -1        0  unknown  no
## 3590  2008-05-15      850        6    -1        0  unknown  no
## 3591  2008-05-15      420        2    -1        0  unknown  no
## 3592  2008-05-15      118        4    -1        0  unknown  no
## 3593  2008-05-15       71        3    -1        0  unknown  no
## 3594  2008-05-15      103        3    -1        0  unknown  no
## 3595  2008-05-15      314       11    -1        0  unknown  no
## 3596  2008-05-15      196        4    -1        0  unknown  no
## 3597  2008-05-15      151        2    -1        0  unknown  no
## 3598  2008-05-15      516        9    -1        0  unknown  no
## 3599  2008-05-15      855        4    -1        0  unknown  no
## 3600  2008-05-15      392        2    -1        0  unknown  no
## 3601  2008-05-15      395        2    -1        0  unknown  no
## 3602  2008-05-15       78        4    -1        0  unknown  no
## 3603  2008-05-15      875        5    -1        0  unknown  no
## 3604  2008-05-15      124        2    -1        0  unknown  no
## 3605  2008-05-15       24       18    -1        0  unknown  no
## 3606  2008-05-15      190        6    -1        0  unknown  no
## 3607  2008-05-15       53        3    -1        0  unknown  no
## 3608  2008-05-15      278        4    -1        0  unknown  no
## 3609  2008-05-15      284        2    -1        0  unknown  no
## 3610  2008-05-15       68        3    -1        0  unknown  no
## 3611  2008-05-15      262        4    -1        0  unknown  no
## 3612  2008-05-15      391        3    -1        0  unknown  no
## 3613  2008-05-15      343        5    -1        0  unknown  no
## 3614  2008-05-15      263        4    -1        0  unknown  no
## 3615  2008-05-15      214        4    -1        0  unknown  no
## 3616  2008-05-15       88        3    -1        0  unknown  no
## 3617  2008-05-15      262        4    -1        0  unknown  no
## 3618  2008-05-15      255       12    -1        0  unknown  no
## 3619  2008-05-15      202        4    -1        0  unknown  no
## 3620  2008-05-15      438        5    -1        0  unknown  no
## 3621  2008-05-15       88        2    -1        0  unknown  no
## 3622  2008-05-15      311        3    -1        0  unknown  no
## 3623  2008-05-15      302        8    -1        0  unknown  no
## 3624  2008-05-15      213        2    -1        0  unknown  no
## 3625  2008-05-15      214        4    -1        0  unknown  no
## 3626  2008-05-15       90        3    -1        0  unknown  no
## 3627  2008-05-15      293        2    -1        0  unknown  no
## 3628  2008-05-15      448        4    -1        0  unknown  no
## 3629  2008-05-15       70        6    -1        0  unknown  no
## 3630  2008-05-15      347        4    -1        0  unknown  no
## 3631  2008-05-15      320        3    -1        0  unknown  no
## 3632  2008-05-15      175        2    -1        0  unknown  no
## 3633  2008-05-15      222       12    -1        0  unknown  no
## 3634  2008-05-15       98        2    -1        0  unknown  no
## 3635  2008-05-15      734        5    -1        0  unknown  no
## 3636  2008-05-15      177        3    -1        0  unknown  no
## 3637  2008-05-15      121        3    -1        0  unknown  no
## 3638  2008-05-15       73        7    -1        0  unknown  no
## 3639  2008-05-15       65        7    -1        0  unknown  no
## 3640  2008-05-15      543       12    -1        0  unknown  no
## 3641  2008-05-15      186        3    -1        0  unknown  no
## 3642  2008-05-15      174        4    -1        0  unknown  no
## 3643  2008-05-15      374        5    -1        0  unknown  no
## 3644  2008-05-15      241        2    -1        0  unknown  no
## 3645  2008-05-15      139        7    -1        0  unknown  no
## 3646  2008-05-15      156       13    -1        0  unknown  no
## 3647  2008-05-15      137        2    -1        0  unknown  no
## 3648  2008-05-15       67        4    -1        0  unknown  no
## 3649  2008-05-15      239        2    -1        0  unknown  no
## 3650  2008-05-15      178        2    -1        0  unknown  no
## 3651  2008-05-15      297        1    -1        0  unknown  no
## 3652  2008-05-15      491        2    -1        0  unknown  no
## 3653  2008-05-15      377        4    -1        0  unknown  no
## 3654  2008-05-16       84        2    -1        0  unknown  no
## 3655  2008-05-16      122        2    -1        0  unknown  no
## 3656  2008-05-16      107        6    -1        0  unknown  no
## 3657  2008-05-16       95        3    -1        0  unknown  no
## 3658  2008-05-16      248        3    -1        0  unknown  no
## 3659  2008-05-16       30        3    -1        0  unknown  no
## 3660  2008-05-16       97        1    -1        0  unknown  no
## 3661  2008-05-16      336        2    -1        0  unknown  no
## 3662  2008-05-16       28        4    -1        0  unknown  no
## 3663  2008-05-16      329        3    -1        0  unknown  no
## 3664  2008-05-16      208        3    -1        0  unknown  no
## 3665  2008-05-16      597       22    -1        0  unknown  no
## 3666  2008-05-16       29        1    -1        0  unknown  no
## 3667  2008-05-16      247        1    -1        0  unknown  no
## 3668  2008-05-16      343        1    -1        0  unknown  no
## 3669  2008-05-16      214        1    -1        0  unknown  no
## 3670  2008-05-16      266        6    -1        0  unknown  no
## 3671  2008-05-16      137        1    -1        0  unknown  no
## 3672  2008-05-16      206        4    -1        0  unknown  no
## 3673  2008-05-16      129        1    -1        0  unknown  no
## 3674  2008-05-16       69       15    -1        0  unknown  no
## 3675  2008-05-16      228        1    -1        0  unknown  no
## 3676  2008-05-16      259        1    -1        0  unknown  no
## 3677  2008-05-16      144        1    -1        0  unknown  no
## 3678  2008-05-16      515        1    -1        0  unknown yes
## 3679  2008-05-16       29        1    -1        0  unknown  no
## 3680  2008-05-16      512        1    -1        0  unknown  no
## 3681  2008-05-16      179        1    -1        0  unknown  no
## 3682  2008-05-16      813        1    -1        0  unknown yes
## 3683  2008-05-16      601        1    -1        0  unknown  no
## 3684  2008-05-16       73        1    -1        0  unknown  no
## 3685  2008-05-16      144        4    -1        0  unknown  no
## 3686  2008-05-16      271        1    -1        0  unknown  no
## 3687  2008-05-16      230        3    -1        0  unknown  no
## 3688  2008-05-16      456        1    -1        0  unknown  no
## 3689  2008-05-16       75        1    -1        0  unknown  no
## 3690  2008-05-16      225        1    -1        0  unknown  no
## 3691  2008-05-16      387        1    -1        0  unknown  no
## 3692  2008-05-16      286        3    -1        0  unknown  no
## 3693  2008-05-16      286        1    -1        0  unknown  no
## 3694  2008-05-16      111       11    -1        0  unknown  no
## 3695  2008-05-16      448        2    -1        0  unknown  no
## 3696  2008-05-16      223        3    -1        0  unknown  no
## 3697  2008-05-16      312        1    -1        0  unknown  no
## 3698  2008-05-16       93        1    -1        0  unknown  no
## 3699  2008-05-16      212        1    -1        0  unknown  no
## 3700  2008-05-16      178        1    -1        0  unknown  no
## 3701  2008-05-16      111        1    -1        0  unknown  no
## 3702  2008-05-16      803        1    -1        0  unknown yes
## 3703  2008-05-16      844        1    -1        0  unknown yes
## 3704  2008-05-16      297        1    -1        0  unknown  no
## 3705  2008-05-16       25        1    -1        0  unknown  no
## 3706  2008-05-16      529        4    -1        0  unknown  no
## 3707  2008-05-16       99        1    -1        0  unknown  no
## 3708  2008-05-16      137        1    -1        0  unknown  no
## 3709  2008-05-16      676        1    -1        0  unknown yes
## 3710  2008-05-16      656        2    -1        0  unknown  no
## 3711  2008-05-16      249        1    -1        0  unknown  no
## 3712  2008-05-16       88        6    -1        0  unknown  no
## 3713  2008-05-16     1252        1    -1        0  unknown yes
## 3714  2008-05-16      228        2    -1        0  unknown  no
## 3715  2008-05-16     1143        3    -1        0  unknown yes
## 3716  2008-05-16      283        1    -1        0  unknown  no
## 3717  2008-05-16      118        2    -1        0  unknown  no
## 3718  2008-05-16      129        1    -1        0  unknown  no
## 3719  2008-05-16      103        1    -1        0  unknown  no
## 3720  2008-05-16      213        1    -1        0  unknown  no
## 3721  2008-05-16      132        1    -1        0  unknown  no
## 3722  2008-05-16      122        1    -1        0  unknown  no
## 3723  2008-05-16      130        4    -1        0  unknown  no
## 3724  2008-05-16      627        1    -1        0  unknown  no
## 3725  2008-05-16      207        1    -1        0  unknown  no
## 3726  2008-05-16      114        2    -1        0  unknown  no
## 3727  2008-05-16      216        1    -1        0  unknown  no
## 3728  2008-05-16      250        1    -1        0  unknown  no
## 3729  2008-05-16       91        1    -1        0  unknown  no
## 3730  2008-05-16      159        1    -1        0  unknown  no
## 3731  2008-05-16      528        1    -1        0  unknown yes
## 3732  2008-05-16       86        1    -1        0  unknown  no
## 3733  2008-05-16      731        4    -1        0  unknown  no
## 3734  2008-05-16       37        1    -1        0  unknown  no
## 3735  2008-05-16       46        1    -1        0  unknown  no
## 3736  2008-05-16       49        1    -1        0  unknown  no
## 3737  2008-05-16      356        2    -1        0  unknown  no
## 3738  2008-05-16      107        2    -1        0  unknown  no
## 3739  2008-05-16      248        1    -1        0  unknown  no
## 3740  2008-05-16      242        7    -1        0  unknown  no
## 3741  2008-05-16      134        3    -1        0  unknown  no
## 3742  2008-05-16      355        2    -1        0  unknown  no
## 3743  2008-05-16      149        1    -1        0  unknown  no
## 3744  2008-05-16      346        1    -1        0  unknown  no
## 3745  2008-05-16      370        1    -1        0  unknown  no
## 3746  2008-05-16      261        1    -1        0  unknown  no
## 3747  2008-05-16      330        4    -1        0  unknown  no
## 3748  2008-05-16      537        1    -1        0  unknown  no
## 3749  2008-05-16      134        1    -1        0  unknown  no
## 3750  2008-05-16      688        1    -1        0  unknown yes
## 3751  2008-05-16       84        1    -1        0  unknown  no
## 3752  2008-05-16      125        1    -1        0  unknown  no
## 3753  2008-05-16      139        2    -1        0  unknown  no
## 3754  2008-05-16      167        1    -1        0  unknown  no
## 3755  2008-05-16       25        1    -1        0  unknown  no
## 3756  2008-05-16      244        1    -1        0  unknown  no
## 3757  2008-05-16      140        1    -1        0  unknown  no
## 3758  2008-05-16      165        1    -1        0  unknown  no
## 3759  2008-05-16      122        1    -1        0  unknown  no
## 3760  2008-05-16      130        2    -1        0  unknown  no
## 3761  2008-05-16      345        1    -1        0  unknown  no
## 3762  2008-05-16      277        6    -1        0  unknown  no
## 3763  2008-05-16      145        1    -1        0  unknown  no
## 3764  2008-05-16      300        1    -1        0  unknown  no
## 3765  2008-05-16      214        1    -1        0  unknown  no
## 3766  2008-05-16      140        1    -1        0  unknown  no
## 3767  2008-05-16      140        1    -1        0  unknown  no
## 3768  2008-05-16      132        1    -1        0  unknown  no
## 3769  2008-05-16       96        2    -1        0  unknown  no
## 3770  2008-05-16      144        2    -1        0  unknown  no
## 3771  2008-05-16      803        1    -1        0  unknown yes
## 3772  2008-05-16      225        4    -1        0  unknown  no
## 3773  2008-05-16       73        1    -1        0  unknown  no
## 3774  2008-05-16      260        1    -1        0  unknown  no
## 3775  2008-05-16      754        1    -1        0  unknown  no
## 3776  2008-05-16      211        2    -1        0  unknown  no
## 3777  2008-05-16      192        1    -1        0  unknown  no
## 3778  2008-05-16      203        1    -1        0  unknown  no
## 3779  2008-05-16       24        1    -1        0  unknown  no
## 3780  2008-05-16      171        2    -1        0  unknown  no
## 3781  2008-05-16      136        1    -1        0  unknown  no
## 3782  2008-05-16       42       10    -1        0  unknown  no
## 3783  2008-05-16      343        1    -1        0  unknown  no
## 3784  2008-05-16      111        1    -1        0  unknown  no
## 3785  2008-05-16       77        1    -1        0  unknown  no
## 3786  2008-05-16      268        6    -1        0  unknown  no
## 3787  2008-05-16      217        2    -1        0  unknown  no
## 3788  2008-05-16      360        1    -1        0  unknown  no
## 3789  2008-05-16      122        3    -1        0  unknown  no
## 3790  2008-05-16       47        1    -1        0  unknown  no
## 3791  2008-05-16      241        1    -1        0  unknown  no
## 3792  2008-05-16      204        1    -1        0  unknown  no
## 3793  2008-05-16      601        1    -1        0  unknown  no
## 3794  2008-05-16      178        2    -1        0  unknown  no
## 3795  2008-05-16      306        1    -1        0  unknown  no
## 3796  2008-05-16      410        1    -1        0  unknown  no
## 3797  2008-05-16      265        1    -1        0  unknown  no
## 3798  2008-05-16      108        2    -1        0  unknown  no
## 3799  2008-05-16      172        4    -1        0  unknown  no
## 3800  2008-05-16      184        2    -1        0  unknown  no
## 3801  2008-05-16      424        1    -1        0  unknown  no
## 3802  2008-05-16      359        1    -1        0  unknown  no
## 3803  2008-05-16      123        1    -1        0  unknown  no
## 3804  2008-05-16      169        1    -1        0  unknown  no
## 3805  2008-05-16      787        1    -1        0  unknown yes
## 3806  2008-05-16      241        1    -1        0  unknown  no
## 3807  2008-05-16      141        1    -1        0  unknown  no
## 3808  2008-05-16       22        4    -1        0  unknown  no
## 3809  2008-05-16      326        1    -1        0  unknown  no
## 3810  2008-05-16      317        1    -1        0  unknown  no
## 3811  2008-05-16      196        3    -1        0  unknown  no
## 3812  2008-05-16      270        1    -1        0  unknown  no
## 3813  2008-05-16      107        1    -1        0  unknown  no
## 3814  2008-05-16      679       17    -1        0  unknown  no
## 3815  2008-05-16      576        1    -1        0  unknown  no
## 3816  2008-05-16      102        1    -1        0  unknown  no
## 3817  2008-05-16      161        3    -1        0  unknown  no
## 3818  2008-05-16      206        2    -1        0  unknown  no
## 3819  2008-05-16       33        1    -1        0  unknown  no
## 3820  2008-05-16      619        2    -1        0  unknown yes
## 3821  2008-05-16      230        1    -1        0  unknown  no
## 3822  2008-05-16       27        2    -1        0  unknown  no
## 3823  2008-05-16      131        1    -1        0  unknown  no
## 3824  2008-05-16       38        2    -1        0  unknown  no
## 3825  2008-05-16      322        2    -1        0  unknown  no
## 3826  2008-05-16      187        1    -1        0  unknown  no
## 3827  2008-05-16      124        1    -1        0  unknown  no
## 3828  2008-05-16      107        2    -1        0  unknown  no
## 3829  2008-05-16      379        1    -1        0  unknown  no
## 3830  2008-05-16     1230        3    -1        0  unknown yes
## 3831  2008-05-16      767        2    -1        0  unknown yes
## 3832  2008-05-16       95        1    -1        0  unknown  no
## 3833  2008-05-16       42        3    -1        0  unknown  no
## 3834  2008-05-16      197        1    -1        0  unknown  no
## 3835  2008-05-16      320        2    -1        0  unknown  no
## 3836  2008-05-16      912        1    -1        0  unknown yes
## 3837  2008-05-16      178        1    -1        0  unknown  no
## 3838  2008-05-16      230        1    -1        0  unknown  no
## 3839  2008-05-16      631        3    -1        0  unknown  no
## 3840  2008-05-16      489        2    -1        0  unknown  no
## 3841  2008-05-16      894        1    -1        0  unknown yes
## 3842  2008-05-16       38        3    -1        0  unknown  no
## 3843  2008-05-16      323        4    -1        0  unknown  no
## 3844  2008-05-16      335        1    -1        0  unknown  no
## 3845  2008-05-16      161        1    -1        0  unknown  no
## 3846  2008-05-16      410        3    -1        0  unknown  no
## 3847  2008-05-16      374        2    -1        0  unknown  no
## 3848  2008-05-16      280        1    -1        0  unknown  no
## 3849  2008-05-16      181        3    -1        0  unknown  no
## 3850  2008-05-16      193        8    -1        0  unknown  no
## 3851  2008-05-16      166        2    -1        0  unknown  no
## 3852  2008-05-16      865        1    -1        0  unknown  no
## 3853  2008-05-16      258        2    -1        0  unknown  no
## 3854  2008-05-16      215        1    -1        0  unknown  no
## 3855  2008-05-16      136        2    -1        0  unknown  no
## 3856  2008-05-16      381        2    -1        0  unknown  no
## 3857  2008-05-16      412        1    -1        0  unknown  no
## 3858  2008-05-16      376        2    -1        0  unknown  no
## 3859  2008-05-16      393        2    -1        0  unknown  no
## 3860  2008-05-16       56        3    -1        0  unknown  no
## 3861  2008-05-16      112        4    -1        0  unknown  no
## 3862  2008-05-16      155        3    -1        0  unknown  no
## 3863  2008-05-16      703        4    -1        0  unknown  no
## 3864  2008-05-16      141        2    -1        0  unknown  no
## 3865  2008-05-16      475        2    -1        0  unknown  no
## 3866  2008-05-16      471        2    -1        0  unknown  no
## 3867  2008-05-16      121        1    -1        0  unknown  no
## 3868  2008-05-16      159        1    -1        0  unknown  no
## 3869  2008-05-16      177        4    -1        0  unknown  no
## 3870  2008-05-16      344        2    -1        0  unknown  no
## 3871  2008-05-16      404        1    -1        0  unknown  no
## 3872  2008-05-16      287        4    -1        0  unknown  no
## 3873  2008-05-16      329        1    -1        0  unknown  no
## 3874  2008-05-16      433        1    -1        0  unknown  no
## 3875  2008-05-16      216        1    -1        0  unknown  no
## 3876  2008-05-16      323        2    -1        0  unknown  no
## 3877  2008-05-16     1340        1    -1        0  unknown yes
## 3878  2008-05-16      132       13    -1        0  unknown  no
## 3879  2008-05-16      199        4    -1        0  unknown  no
## 3880  2008-05-16      558        3    -1        0  unknown  no
## 3881  2008-05-16      221        2    -1        0  unknown  no
## 3882  2008-05-16      897        1    -1        0  unknown yes
## 3883  2008-05-16       80        2    -1        0  unknown  no
## 3884  2008-05-16       90        2    -1        0  unknown  no
## 3885  2008-05-16      123        3    -1        0  unknown  no
## 3886  2008-05-16      461        2    -1        0  unknown  no
## 3887  2008-05-16      213       16    -1        0  unknown  no
## 3888  2008-05-16      193       11    -1        0  unknown  no
## 3889  2008-05-16      428        1    -1        0  unknown  no
## 3890  2008-05-16      411        2    -1        0  unknown  no
## 3891  2008-05-16      291        1    -1        0  unknown  no
## 3892  2008-05-16      136        1    -1        0  unknown  no
## 3893  2008-05-16      112        1    -1        0  unknown  no
## 3894  2008-05-16      270        1    -1        0  unknown  no
## 3895  2008-05-16      124        1    -1        0  unknown  no
## 3896  2008-05-16      214        4    -1        0  unknown  no
## 3897  2008-05-16      239        3    -1        0  unknown  no
## 3898  2008-05-16      323        1    -1        0  unknown  no
## 3899  2008-05-16       94        1    -1        0  unknown  no
## 3900  2008-05-16       74        1    -1        0  unknown  no
## 3901  2008-05-16      107        1    -1        0  unknown  no
## 3902  2008-05-16       51        1    -1        0  unknown  no
## 3903  2008-05-16      109        1    -1        0  unknown  no
## 3904  2008-05-16      378        1    -1        0  unknown  no
## 3905  2008-05-16      217        1    -1        0  unknown  no
## 3906  2008-05-16      136        1    -1        0  unknown  no
## 3907  2008-05-16     1161        3    -1        0  unknown  no
## 3908  2008-05-16      103        1    -1        0  unknown  no
## 3909  2008-05-16      467        1    -1        0  unknown  no
## 3910  2008-05-16      290        1    -1        0  unknown  no
## 3911  2008-05-16      131        1    -1        0  unknown  no
## 3912  2008-05-16      168        2    -1        0  unknown  no
## 3913  2008-05-16      764        7    -1        0  unknown  no
## 3914  2008-05-16      194        3    -1        0  unknown  no
## 3915  2008-05-16       16       25    -1        0  unknown  no
## 3916  2008-05-16      208        5    -1        0  unknown  no
## 3917  2008-05-16      148       18    -1        0  unknown  no
## 3918  2008-05-16      242        3    -1        0  unknown  no
## 3919  2008-05-16      269        2    -1        0  unknown  no
## 3920  2008-05-16      370        2    -1        0  unknown  no
## 3921  2008-05-16      274        8    -1        0  unknown  no
## 3922  2008-05-16      326        1    -1        0  unknown  no
## 3923  2008-05-16      337        2    -1        0  unknown  no
## 3924  2008-05-16      788        2    -1        0  unknown  no
## 3925  2008-05-16      353        4    -1        0  unknown  no
## 3926  2008-05-16       14       15    -1        0  unknown  no
## 3927  2008-05-16       92        1    -1        0  unknown  no
## 3928  2008-05-16      698        9    -1        0  unknown  no
## 3929  2008-05-16      180        1    -1        0  unknown  no
## 3930  2008-05-16      467        1    -1        0  unknown  no
## 3931  2008-05-16      218        2    -1        0  unknown  no
## 3932  2008-05-16      233        1    -1        0  unknown  no
## 3933  2008-05-16      304        2    -1        0  unknown  no
## 3934  2008-05-16      315        3    -1        0  unknown  no
## 3935  2008-05-16       40        5    -1        0  unknown  no
## 3936  2008-05-16      698        1    -1        0  unknown  no
## 3937  2008-05-16       76       21    -1        0  unknown  no
## 3938  2008-05-16      355        2    -1        0  unknown  no
## 3939  2008-05-16      557        4    -1        0  unknown  no
## 3940  2008-05-16       97        3    -1        0  unknown  no
## 3941  2008-05-16      148        2    -1        0  unknown  no
## 3942  2008-05-16      128        2    -1        0  unknown  no
## 3943  2008-05-16      130        3    -1        0  unknown  no
## 3944  2008-05-16      280        2    -1        0  unknown  no
## 3945  2008-05-16      152        2    -1        0  unknown  no
## 3946  2008-05-16      283        2    -1        0  unknown  no
## 3947  2008-05-16      523        3    -1        0  unknown  no
## 3948  2008-05-16     1128        3    -1        0  unknown  no
## 3949  2008-05-16      171        4    -1        0  unknown  no
## 3950  2008-05-16      174       17    -1        0  unknown  no
## 3951  2008-05-16       71       11    -1        0  unknown  no
## 3952  2008-05-16       84        4    -1        0  unknown  no
## 3953  2008-05-16      221        2    -1        0  unknown  no
## 3954  2008-05-16      234        2    -1        0  unknown  no
## 3955  2008-05-16      138        2    -1        0  unknown  no
## 3956  2008-05-16      339        5    -1        0  unknown  no
## 3957  2008-05-16      509        2    -1        0  unknown  no
## 3958  2008-05-16      254       17    -1        0  unknown  no
## 3959  2008-05-16      164        2    -1        0  unknown  no
## 3960  2008-05-16      243        3    -1        0  unknown  no
## 3961  2008-05-16      344        4    -1        0  unknown  no
## 3962  2008-05-16      131        4    -1        0  unknown  no
## 3963  2008-05-16      806        4    -1        0  unknown  no
## 3964  2008-05-16      251        4    -1        0  unknown  no
## 3965  2008-05-16     1135        2    -1        0  unknown  no
## 3966  2008-05-16      312        3    -1        0  unknown  no
## 3967  2008-05-16      302        4    -1        0  unknown  no
## 3968  2008-05-16      292        8    -1        0  unknown  no
## 3969  2008-05-16      279        2    -1        0  unknown  no
## 3970  2008-05-16      187       19    -1        0  unknown  no
## 3971  2008-05-16      198        5    -1        0  unknown  no
## 3972  2008-05-16     1408        2    -1        0  unknown  no
## 3973  2008-05-16      827        2    -1        0  unknown  no
## 3974  2008-05-16      303        5    -1        0  unknown  no
## 3975  2008-05-16       67        2    -1        0  unknown  no
## 3976  2008-05-16      680        3    -1        0  unknown  no
## 3977  2008-05-16      160        6    -1        0  unknown  no
## 3978  2008-05-16      251        3    -1        0  unknown  no
## 3979  2008-05-16       21        3    -1        0  unknown  no
## 3980  2008-05-16      218        2    -1        0  unknown  no
## 3981  2008-05-16       81        6    -1        0  unknown  no
## 3982  2008-05-16      476        3    -1        0  unknown  no
## 3983  2008-05-16     1297        3    -1        0  unknown yes
## 3984  2008-05-16        4        2    -1        0  unknown  no
## 3985  2008-05-16      283        3    -1        0  unknown  no
## 3986  2008-05-16      323        3    -1        0  unknown  no
## 3987  2008-05-16      248        2    -1        0  unknown  no
## 3988  2008-05-16      541        5    -1        0  unknown  no
## 3989  2008-05-16      427        3    -1        0  unknown  no
## 3990  2008-05-16      148        9    -1        0  unknown  no
## 3991  2008-05-16      408       10    -1        0  unknown  no
## 3992  2008-05-16      236        2    -1        0  unknown  no
## 3993  2008-05-16      428        2    -1        0  unknown  no
## 3994  2008-05-16       32        3    -1        0  unknown  no
## 3995  2008-05-16      330       19    -1        0  unknown  no
## 3996  2008-05-16      851        2    -1        0  unknown  no
## 3997  2008-05-16      522        5    -1        0  unknown  no
## 3998  2008-05-16      320        3    -1        0  unknown  no
## 3999  2008-05-16      165        4    -1        0  unknown  no
## 4000  2008-05-16     1193        5    -1        0  unknown yes
## 4001  2008-05-16      730        2    -1        0  unknown  no
## 4002  2008-05-16     1144        3    -1        0  unknown  no
## 4003  2008-05-16      167        2    -1        0  unknown  no
## 4004  2008-05-16     1023        4    -1        0  unknown  no
## 4005  2008-05-16      469        2    -1        0  unknown  no
## 4006  2008-05-16      385        7    -1        0  unknown  no
## 4007  2008-05-16      260        6    -1        0  unknown  no
## 4008  2008-05-16      169        3    -1        0  unknown  no
## 4009  2008-05-16      409        3    -1        0  unknown  no
## 4010  2008-05-16      165        6    -1        0  unknown  no
## 4011  2008-05-16      437        2    -1        0  unknown  no
## 4012  2008-05-16       89        2    -1        0  unknown  no
## 4013  2008-05-16      261        6    -1        0  unknown  no
## 4014  2008-05-16      294        4    -1        0  unknown  no
## 4015  2008-05-16      343        4    -1        0  unknown  no
## 4016  2008-05-16     1245       25    -1        0  unknown  no
## 4017  2008-05-16      498        2    -1        0  unknown  no
## 4018  2008-05-16      148        4    -1        0  unknown  no
## 4019  2008-05-16      134        4    -1        0  unknown  no
## 4020  2008-05-16      230        2    -1        0  unknown  no
## 4021  2008-05-16      192       32    -1        0  unknown  no
## 4022  2008-05-16       65        3    -1        0  unknown  no
## 4023  2008-05-16      237        3    -1        0  unknown  no
## 4024  2008-05-16      239        2    -1        0  unknown  no
## 4025  2008-05-16      196        6    -1        0  unknown  no
## 4026  2008-05-16      243        2    -1        0  unknown  no
## 4027  2008-05-16      393        2    -1        0  unknown  no
## 4028  2008-05-16      512        6    -1        0  unknown  no
## 4029  2008-05-16      218        3    -1        0  unknown  no
## 4030  2008-05-16      215        3    -1        0  unknown  no
## 4031  2008-05-16      186        5    -1        0  unknown  no
## 4032  2008-05-16      299        4    -1        0  unknown  no
## 4033  2008-05-16      107        3    -1        0  unknown  no
## 4034  2008-05-16      103        7    -1        0  unknown  no
## 4035  2008-05-16      297        4    -1        0  unknown  no
## 4036  2008-05-16     1064        4    -1        0  unknown yes
## 4037  2008-05-16       24        4    -1        0  unknown  no
## 4038  2008-05-16      757        6    -1        0  unknown  no
## 4039  2008-05-16       90        7    -1        0  unknown  no
## 4040  2008-05-16       59        5    -1        0  unknown  no
## 4041  2008-05-16      102        4    -1        0  unknown  no
## 4042  2008-05-16      293        7    -1        0  unknown  no
## 4043  2008-05-16     1187        4    -1        0  unknown yes
## 4044  2008-05-16      427        3    -1        0  unknown  no
## 4045  2008-05-19       65        3    -1        0  unknown  no
## 4046  2008-05-19       79       19    -1        0  unknown  no
## 4047  2008-05-19      145        4    -1        0  unknown  no
## 4048  2008-05-19       39        7    -1        0  unknown  no
## 4049  2008-05-19      105        2    -1        0  unknown  no
## 4050  2008-05-19      311        2    -1        0  unknown  no
## 4051  2008-05-19      179        4    -1        0  unknown  no
## 4052  2008-05-19       62        2    -1        0  unknown  no
## 4053  2008-05-19      128        3    -1        0  unknown  no
## 4054  2008-05-19      171        2    -1        0  unknown  no
## 4055  2008-05-19      134        2    -1        0  unknown  no
## 4056  2008-05-19      594        2    -1        0  unknown  no
## 4057  2008-05-19       55        3    -1        0  unknown  no
## 4058  2008-05-19       66        2    -1        0  unknown  no
## 4059  2008-05-19       92        2    -1        0  unknown  no
## 4060  2008-05-19       19        5    -1        0  unknown  no
## 4061  2008-05-19      501        3    -1        0  unknown  no
## 4062  2008-05-19      114        2    -1        0  unknown  no
## 4063  2008-05-19      221        2    -1        0  unknown  no
## 4064  2008-05-19      221        4    -1        0  unknown  no
## 4065  2008-05-19      374        6    -1        0  unknown  no
## 4066  2008-05-19      123        1    -1        0  unknown  no
## 4067  2008-05-19      166        1    -1        0  unknown  no
## 4068  2008-05-19       37        1    -1        0  unknown  no
## 4069  2008-05-19       35        1    -1        0  unknown  no
## 4070  2008-05-19      668        7    -1        0  unknown  no
## 4071  2008-05-19       88        5    -1        0  unknown  no
## 4072  2008-05-19       77        2    -1        0  unknown  no
## 4073  2008-05-19      312        1    -1        0  unknown  no
## 4074  2008-05-19      181        1    -1        0  unknown  no
## 4075  2008-05-19      134        3    -1        0  unknown  no
## 4076  2008-05-19       61        4    -1        0  unknown  no
## 4077  2008-05-19      258        1    -1        0  unknown  no
## 4078  2008-05-19      131        2    -1        0  unknown  no
## 4079  2008-05-19       71        1    -1        0  unknown  no
## 4080  2008-05-19      153        1    -1        0  unknown  no
## 4081  2008-05-19      405        3    -1        0  unknown  no
## 4082  2008-05-19      256        1    -1        0  unknown  no
## 4083  2008-05-19      131        1    -1        0  unknown  no
## 4084  2008-05-19      219        1    -1        0  unknown  no
## 4085  2008-05-19      468        1    -1        0  unknown  no
## 4086  2008-05-19      326        2    -1        0  unknown  no
## 4087  2008-05-19      412        1    -1        0  unknown  no
## 4088  2008-05-19      579        1    -1        0  unknown  no
## 4089  2008-05-19      277        3    -1        0  unknown  no
## 4090  2008-05-19      316        2    -1        0  unknown  no
## 4091  2008-05-19      882        1    -1        0  unknown yes
## 4092  2008-05-19      380        1    -1        0  unknown  no
## 4093  2008-05-19      169        1    -1        0  unknown  no
## 4094  2008-05-19      127        1    -1        0  unknown  no
## 4095  2008-05-19      122        6    -1        0  unknown  no
## 4096  2008-05-19       83        4    -1        0  unknown  no
## 4097  2008-05-19      318        1    -1        0  unknown  no
## 4098  2008-05-19       29        3    -1        0  unknown  no
## 4099  2008-05-19      218        1    -1        0  unknown  no
## 4100  2008-05-19      144        2    -1        0  unknown  no
## 4101  2008-05-19      130        2    -1        0  unknown  no
## 4102  2008-05-19      429        1    -1        0  unknown  no
## 4103  2008-05-19       27        1    -1        0  unknown  no
## 4104  2008-05-19      546        2    -1        0  unknown  no
## 4105  2008-05-19      343        2    -1        0  unknown  no
## 4106  2008-05-19       95        1    -1        0  unknown  no
## 4107  2008-05-19      156        1    -1        0  unknown  no
## 4108  2008-05-19      112        1    -1        0  unknown  no
## 4109  2008-05-19      351        1    -1        0  unknown  no
## 4110  2008-05-19      198        1    -1        0  unknown  no
## 4111  2008-05-19      165        1    -1        0  unknown  no
## 4112  2008-05-19      134        2    -1        0  unknown  no
## 4113  2008-05-19      268        6    -1        0  unknown  no
## 4114  2008-05-19      298        1    -1        0  unknown  no
## 4115  2008-05-19       63        1    -1        0  unknown  no
## 4116  2008-05-19      455        1    -1        0  unknown  no
## 4117  2008-05-19      188        2    -1        0  unknown  no
## 4118  2008-05-19      241        1    -1        0  unknown  no
## 4119  2008-05-19      201        1    -1        0  unknown  no
## 4120  2008-05-19       27        1    -1        0  unknown  no
## 4121  2008-05-19      206        1    -1        0  unknown  no
## 4122  2008-05-19       68        1    -1        0  unknown  no
## 4123  2008-05-19       82        3    -1        0  unknown  no
## 4124  2008-05-19       97        2    -1        0  unknown  no
## 4125  2008-05-19      138        1    -1        0  unknown  no
## 4126  2008-05-19      285        2    -1        0  unknown  no
## 4127  2008-05-19      135        1    -1        0  unknown  no
## 4128  2008-05-19      268        3    -1        0  unknown  no
## 4129  2008-05-19      267        1    -1        0  unknown  no
## 4130  2008-05-19      382        2    -1        0  unknown  no
## 4131  2008-05-19      208        5    -1        0  unknown  no
## 4132  2008-05-19      259        3    -1        0  unknown  no
## 4133  2008-05-19       18        1    -1        0  unknown  no
## 4134  2008-05-19      234        1    -1        0  unknown  no
## 4135  2008-05-19      792        4    -1        0  unknown  no
## 4136  2008-05-19       95        1    -1        0  unknown  no
## 4137  2008-05-19      943        2    -1        0  unknown yes
## 4138  2008-05-19      352        1    -1        0  unknown  no
## 4139  2008-05-19      798        1    -1        0  unknown  no
## 4140  2008-05-19       84       12    -1        0  unknown  no
## 4141  2008-05-19      100        3    -1        0  unknown  no
## 4142  2008-05-19       85        4    -1        0  unknown  no
## 4143  2008-05-19      143        1    -1        0  unknown  no
## 4144  2008-05-19      115        1    -1        0  unknown  no
## 4145  2008-05-19       73        1    -1        0  unknown  no
## 4146  2008-05-19       31        1    -1        0  unknown  no
## 4147  2008-05-19      182        2    -1        0  unknown  no
## 4148  2008-05-19      190        1    -1        0  unknown  no
## 4149  2008-05-19      351        1    -1        0  unknown  no
## 4150  2008-05-19      179        1    -1        0  unknown  no
## 4151  2008-05-19      107        2    -1        0  unknown  no
## 4152  2008-05-19      529        3    -1        0  unknown  no
## 4153  2008-05-19       36        1    -1        0  unknown  no
## 4154  2008-05-19      122        2    -1        0  unknown  no
## 4155  2008-05-19      198        1    -1        0  unknown  no
## 4156  2008-05-19       67        1    -1        0  unknown  no
## 4157  2008-05-19      264        1    -1        0  unknown  no
## 4158  2008-05-19      238        3    -1        0  unknown  no
## 4159  2008-05-19      112        1    -1        0  unknown  no
## 4160  2008-05-19       21        2    -1        0  unknown  no
## 4161  2008-05-19       81        1    -1        0  unknown  no
## 4162  2008-05-19      496        3    -1        0  unknown  no
## 4163  2008-05-19       78        3    -1        0  unknown  no
## 4164  2008-05-19      114        2    -1        0  unknown  no
## 4165  2008-05-19      156        5    -1        0  unknown  no
## 4166  2008-05-19      211        2    -1        0  unknown  no
## 4167  2008-05-19      265        1    -1        0  unknown  no
## 4168  2008-05-19       48        2    -1        0  unknown  no
## 4169  2008-05-19      104        2    -1        0  unknown  no
## 4170  2008-05-19      610        1    -1        0  unknown  no
## 4171  2008-05-19      287        1    -1        0  unknown  no
## 4172  2008-05-19       68        2    -1        0  unknown  no
## 4173  2008-05-19      336        1    -1        0  unknown  no
## 4174  2008-05-19      202        1    -1        0  unknown  no
## 4175  2008-05-19      228        1    -1        0  unknown  no
## 4176  2008-05-19      192        1    -1        0  unknown  no
## 4177  2008-05-19      343        1    -1        0  unknown  no
## 4178  2008-05-19       23        1    -1        0  unknown  no
## 4179  2008-05-19      260        1    -1        0  unknown  no
## 4180  2008-05-19      387        1    -1        0  unknown  no
## 4181  2008-05-19       70        1    -1        0  unknown  no
## 4182  2008-05-19      158        2    -1        0  unknown  no
## 4183  2008-05-19       35        3    -1        0  unknown  no
## 4184  2008-05-19      145        3    -1        0  unknown  no
## 4185  2008-05-19      257        1    -1        0  unknown  no
## 4186  2008-05-19      607        1    -1        0  unknown yes
## 4187  2008-05-19      214        3    -1        0  unknown  no
## 4188  2008-05-19      127        5    -1        0  unknown  no
## 4189  2008-05-19      260       11    -1        0  unknown  no
## 4190  2008-05-19      197        4    -1        0  unknown  no
## 4191  2008-05-19      174        2    -1        0  unknown  no
## 4192  2008-05-19      144        2    -1        0  unknown  no
## 4193  2008-05-19      222        2    -1        0  unknown  no
## 4194  2008-05-19      136        2    -1        0  unknown  no
## 4195  2008-05-19      546       12    -1        0  unknown  no
## 4196  2008-05-19       49        2    -1        0  unknown  no
## 4197  2008-05-19      335        4    -1        0  unknown  no
## 4198  2008-05-19      105        1    -1        0  unknown  no
## 4199  2008-05-19      488        3    -1        0  unknown  no
## 4200  2008-05-19     1203        3    -1        0  unknown  no
## 4201  2008-05-19     1022        4    -1        0  unknown yes
## 4202  2008-05-19      128        1    -1        0  unknown  no
## 4203  2008-05-19      126        3    -1        0  unknown  no
## 4204  2008-05-19      387        1    -1        0  unknown  no
## 4205  2008-05-19      258        1    -1        0  unknown  no
## 4206  2008-05-19      199        1    -1        0  unknown  no
## 4207  2008-05-19      364        1    -1        0  unknown  no
## 4208  2008-05-19      123        1    -1        0  unknown  no
## 4209  2008-05-19      201       14    -1        0  unknown  no
## 4210  2008-05-19      193        3    -1        0  unknown  no
## 4211  2008-05-19      159        3    -1        0  unknown  no
## 4212  2008-05-19      131        6    -1        0  unknown  no
## 4213  2008-05-19      166        3    -1        0  unknown  no
## 4214  2008-05-19      480        1    -1        0  unknown  no
## 4215  2008-05-19      149        4    -1        0  unknown  no
## 4216  2008-05-19      110        1    -1        0  unknown  no
## 4217  2008-05-19      396        3    -1        0  unknown  no
## 4218  2008-05-19      124        3    -1        0  unknown  no
## 4219  2008-05-19      163        3    -1        0  unknown  no
## 4220  2008-05-19       13        1    -1        0  unknown  no
## 4221  2008-05-19      259        1    -1        0  unknown  no
## 4222  2008-05-19      162        1    -1        0  unknown  no
## 4223  2008-05-19      102        2    -1        0  unknown  no
## 4224  2008-05-19      723        1    -1        0  unknown  no
## 4225  2008-05-19       89        1    -1        0  unknown  no
## 4226  2008-05-19      703        1    -1        0  unknown  no
## 4227  2008-05-19      257        2    -1        0  unknown  no
## 4228  2008-05-19      289        1    -1        0  unknown  no
## 4229  2008-05-19      361        2    -1        0  unknown  no
## 4230  2008-05-19      314        1    -1        0  unknown  no
## 4231  2008-05-19       83        1    -1        0  unknown  no
## 4232  2008-05-19      215        1    -1        0  unknown  no
## 4233  2008-05-19      115        4    -1        0  unknown  no
## 4234  2008-05-19      147        3    -1        0  unknown  no
## 4235  2008-05-19      285        1    -1        0  unknown  no
## 4236  2008-05-19      102        1    -1        0  unknown  no
## 4237  2008-05-19      183        7    -1        0  unknown  no
## 4238  2008-05-19       70        1    -1        0  unknown  no
## 4239  2008-05-19       19        1    -1        0  unknown  no
## 4240  2008-05-19      346        1    -1        0  unknown  no
## 4241  2008-05-19      643        1    -1        0  unknown  no
## 4242  2008-05-19       78        1    -1        0  unknown  no
## 4243  2008-05-19      411        1    -1        0  unknown  no
## 4244  2008-05-19      133        1    -1        0  unknown  no
## 4245  2008-05-19      193        6    -1        0  unknown  no
## 4246  2008-05-19      590        2    -1        0  unknown  no
## 4247  2008-05-19      151        1    -1        0  unknown  no
## 4248  2008-05-19      109        2    -1        0  unknown  no
## 4249  2008-05-19      263        1    -1        0  unknown  no
## 4250  2008-05-19      103        4    -1        0  unknown  no
## 4251  2008-05-19      333        1    -1        0  unknown  no
## 4252  2008-05-19      104        1    -1        0  unknown  no
## 4253  2008-05-19      191        4    -1        0  unknown  no
## 4254  2008-05-19      571        1    -1        0  unknown  no
## 4255  2008-05-19      180        1    -1        0  unknown  no
## 4256  2008-05-19      657        2    -1        0  unknown  no
## 4257  2008-05-19      107        2    -1        0  unknown  no
## 4258  2008-05-19      335        3    -1        0  unknown  no
## 4259  2008-05-19      120        3    -1        0  unknown  no
## 4260  2008-05-19      219        2    -1        0  unknown  no
## 4261  2008-05-19      148        1    -1        0  unknown  no
## 4262  2008-05-19      214        1    -1        0  unknown  no
## 4263  2008-05-19      400        2    -1        0  unknown  no
## 4264  2008-05-19      503        2    -1        0  unknown  no
## 4265  2008-05-19      125        5    -1        0  unknown  no
## 4266  2008-05-19      329        1    -1        0  unknown  no
## 4267  2008-05-19      194        3    -1        0  unknown  no
## 4268  2008-05-19        7        1    -1        0  unknown  no
## 4269  2008-05-19       53        1    -1        0  unknown  no
## 4270  2008-05-19      344        2    -1        0  unknown  no
## 4271  2008-05-19      104        1    -1        0  unknown  no
## 4272  2008-05-19      552        3    -1        0  unknown yes
## 4273  2008-05-19      345        1    -1        0  unknown  no
## 4274  2008-05-19      263        1    -1        0  unknown  no
## 4275  2008-05-19       88        6    -1        0  unknown  no
## 4276  2008-05-19       44       43    -1        0  unknown  no
## 4277  2008-05-19      401        2    -1        0  unknown  no
## 4278  2008-05-19      178        5    -1        0  unknown  no
## 4279  2008-05-19       53        5    -1        0  unknown  no
## 4280  2008-05-19      349        2    -1        0  unknown  no
## 4281  2008-05-19       34        9    -1        0  unknown  no
## 4282  2008-05-19       48        3    -1        0  unknown  no
## 4283  2008-05-19      182       11    -1        0  unknown  no
## 4284  2008-05-19      147        1    -1        0  unknown  no
## 4285  2008-05-19      457        5    -1        0  unknown  no
## 4286  2008-05-19      193        1    -1        0  unknown  no
## 4287  2008-05-19      142        3    -1        0  unknown  no
## 4288  2008-05-19      123        2    -1        0  unknown  no
## 4289  2008-05-19       65        3    -1        0  unknown  no
## 4290  2008-05-19      420        1    -1        0  unknown  no
## 4291  2008-05-19      100        2    -1        0  unknown  no
## 4292  2008-05-19      403        2    -1        0  unknown  no
## 4293  2008-05-19      229        3    -1        0  unknown  no
## 4294  2008-05-19      445        2    -1        0  unknown  no
## 4295  2008-05-19      206        4    -1        0  unknown  no
## 4296  2008-05-19      182        2    -1        0  unknown  no
## 4297  2008-05-19      183        2    -1        0  unknown  no
## 4298  2008-05-19      140        2    -1        0  unknown  no
## 4299  2008-05-19      134        3    -1        0  unknown  no
## 4300  2008-05-19       88       51    -1        0  unknown  no
## 4301  2008-05-19      234       13    -1        0  unknown  no
## 4302  2008-05-19      215        3    -1        0  unknown  no
## 4303  2008-05-19      194        5    -1        0  unknown  no
## 4304  2008-05-19      394        2    -1        0  unknown  no
## 4305  2008-05-19        5        2    -1        0  unknown  no
## 4306  2008-05-19      408        2    -1        0  unknown  no
## 4307  2008-05-19      114        2    -1        0  unknown  no
## 4308  2008-05-19      210        2    -1        0  unknown  no
## 4309  2008-05-19      243        6    -1        0  unknown  no
## 4310  2008-05-19      180        9    -1        0  unknown  no
## 4311  2008-05-19        8        2    -1        0  unknown  no
## 4312  2008-05-19      458        4    -1        0  unknown  no
## 4313  2008-05-19      313        2    -1        0  unknown  no
## 4314  2008-05-19     1622        2    -1        0  unknown yes
## 4315  2008-05-19      324        2    -1        0  unknown  no
## 4316  2008-05-19      205        3    -1        0  unknown  no
## 4317  2008-05-19      310        2    -1        0  unknown  no
## 4318  2008-05-19      194        2    -1        0  unknown  no
## 4319  2008-05-19      165        5    -1        0  unknown  no
## 4320  2008-05-19       86        7    -1        0  unknown  no
## 4321  2008-05-19      160        2    -1        0  unknown  no
## 4322  2008-05-19      492        6    -1        0  unknown  no
## 4323  2008-05-19      187        3    -1        0  unknown  no
## 4324  2008-05-19      197        4    -1        0  unknown  no
## 4325  2008-05-19       95        5    -1        0  unknown  no
## 4326  2008-05-19      159        3    -1        0  unknown  no
## 4327  2008-05-19      967        6    -1        0  unknown yes
## 4328  2008-05-19      221        2    -1        0  unknown  no
## 4329  2008-05-19      102       13    -1        0  unknown  no
## 4330  2008-05-19      579        5    -1        0  unknown yes
## 4331  2008-05-19      124       63    -1        0  unknown  no
## 4332  2008-05-19      158        5    -1        0  unknown  no
## 4333  2008-05-19      162       10    -1        0  unknown  no
## 4334  2008-05-19      211        2    -1        0  unknown  no
## 4335  2008-05-19       51       41    -1        0  unknown  no
## 4336  2008-05-19      173        5    -1        0  unknown  no
## 4337  2008-05-19      220        3    -1        0  unknown  no
## 4338  2008-05-19      110        2    -1        0  unknown  no
## 4339  2008-05-19       99       26    -1        0  unknown  no
## 4340  2008-05-19      112        7    -1        0  unknown  no
## 4341  2008-05-19      168        4    -1        0  unknown  no
## 4342  2008-05-19      283        3    -1        0  unknown  no
## 4343  2008-05-19      235        7    -1        0  unknown  no
## 4344  2008-05-19      138        8    -1        0  unknown  no
## 4345  2008-05-19      374        6    -1        0  unknown  no
## 4346  2008-05-19      353        4    -1        0  unknown  no
## 4347  2008-05-19      147        2    -1        0  unknown  no
## 4348  2008-05-19      332       10    -1        0  unknown  no
## 4349  2008-05-19      179        9    -1        0  unknown  no
## 4350  2008-05-19      571        5    -1        0  unknown  no
## 4351  2008-05-19      492        9    -1        0  unknown  no
## 4352  2008-05-19      265        5    -1        0  unknown  no
## 4353  2008-05-19      360        2    -1        0  unknown  no
## 4354  2008-05-19      175        2    -1        0  unknown  no
## 4355  2008-05-19       97        9    -1        0  unknown  no
## 4356  2008-05-19       84        3    -1        0  unknown  no
## 4357  2008-05-19       57        7    -1        0  unknown  no
## 4358  2008-05-19      105       11    -1        0  unknown  no
## 4359  2008-05-19      886        3    -1        0  unknown  no
## 4360  2008-05-19      182        8    -1        0  unknown  no
## 4361  2008-05-19      467        4    -1        0  unknown  no
## 4362  2008-05-19       18       14    -1        0  unknown  no
## 4363  2008-05-19       21       11    -1        0  unknown  no
## 4364  2008-05-19      470        4    -1        0  unknown  no
## 4365  2008-05-19       85        3    -1        0  unknown  no
## 4366  2008-05-19      243        2    -1        0  unknown  no
## 4367  2008-05-19      120        7    -1        0  unknown  no
## 4368  2008-05-19      298        2    -1        0  unknown  no
## 4369  2008-05-19      249        2    -1        0  unknown  no
## 4370  2008-05-19       87        5    -1        0  unknown  no
## 4371  2008-05-19      217        2    -1        0  unknown  no
## 4372  2008-05-19       44        4    -1        0  unknown  no
## 4373  2008-05-19      622        2    -1        0  unknown  no
## 4374  2008-05-19      182        2    -1        0  unknown  no
## 4375  2008-05-19      195        4    -1        0  unknown  no
## 4376  2008-05-19      179        2    -1        0  unknown  no
## 4377  2008-05-19       58       10    -1        0  unknown  no
## 4378  2008-05-19     1218        3    -1        0  unknown yes
## 4379  2008-05-19      500        3    -1        0  unknown  no
## 4380  2008-05-19       66        9    -1        0  unknown  no
## 4381  2008-05-19      248        3    -1        0  unknown  no
## 4382  2008-05-19      110        5    -1        0  unknown  no
## 4383  2008-05-19     3078        4    -1        0  unknown  no
## 4384  2008-05-20       21        9    -1        0  unknown  no
## 4385  2008-05-20      150        1    -1        0  unknown  no
## 4386  2008-05-20      148        5    -1        0  unknown  no
## 4387  2008-05-20       91        1    -1        0  unknown  no
## 4388  2008-05-20       34        1    -1        0  unknown  no
## 4389  2008-05-20      201        1    -1        0  unknown  no
## 4390  2008-05-20       70        1    -1        0  unknown  no
## 4391  2008-05-20       19       15    -1        0  unknown  no
## 4392  2008-05-20      351        1    -1        0  unknown  no
## 4393  2008-05-20      182        1    -1        0  unknown  no
## 4394  2008-05-20      365        4    -1        0  unknown  no
## 4395  2008-05-20      257        1    -1        0  unknown  no
## 4396  2008-05-20      280        1    -1        0  unknown  no
## 4397  2008-05-20       16       10    -1        0  unknown  no
## 4398  2008-05-20      140        1    -1        0  unknown  no
## 4399  2008-05-20       21       11    -1        0  unknown  no
## 4400  2008-05-20      184        1    -1        0  unknown  no
## 4401  2008-05-20       20       14    -1        0  unknown  no
## 4402  2008-05-20      107        2    -1        0  unknown  no
## 4403  2008-05-20      446        1    -1        0  unknown yes
## 4404  2008-05-20      661        1    -1        0  unknown  no
## 4405  2008-05-20      172        1    -1        0  unknown  no
## 4406  2008-05-20      125        4    -1        0  unknown  no
## 4407  2008-05-20      280        1    -1        0  unknown  no
## 4408  2008-05-20      216        1    -1        0  unknown  no
## 4409  2008-05-20       81        1    -1        0  unknown  no
## 4410  2008-05-20      409        2    -1        0  unknown  no
## 4411  2008-05-20      226        1    -1        0  unknown  no
## 4412  2008-05-20      191        1    -1        0  unknown  no
## 4413  2008-05-20      171        1    -1        0  unknown  no
## 4414  2008-05-20       13       12    -1        0  unknown  no
## 4415  2008-05-20      133        1    -1        0  unknown  no
## 4416  2008-05-20      656        1    -1        0  unknown  no
## 4417  2008-05-20     1205        1    -1        0  unknown yes
## 4418  2008-05-20      202        6    -1        0  unknown  no
## 4419  2008-05-20      205        1    -1        0  unknown  no
## 4420  2008-05-20      206        1    -1        0  unknown  no
## 4421  2008-05-20       79        1    -1        0  unknown  no
## 4422  2008-05-20      186        4    -1        0  unknown  no
## 4423  2008-05-20      532        1    -1        0  unknown  no
## 4424  2008-05-20       97        2    -1        0  unknown  no
## 4425  2008-05-20      234        5    -1        0  unknown  no
## 4426  2008-05-20      328        1    -1        0  unknown  no
## 4427  2008-05-20      297        1    -1        0  unknown  no
## 4428  2008-05-20     1882        2    -1        0  unknown yes
## 4429  2008-05-20      243        1    -1        0  unknown  no
## 4430  2008-05-20       81        1    -1        0  unknown  no
## 4431  2008-05-20      142        3    -1        0  unknown  no
## 4432  2008-05-20     1334        1    -1        0  unknown yes
## 4433  2008-05-20      775        1    -1        0  unknown  no
## 4434  2008-05-20      335        1    -1        0  unknown  no
## 4435  2008-05-20      168        1    -1        0  unknown  no
## 4436  2008-05-20       68        2    -1        0  unknown  no
## 4437  2008-05-20      121        2    -1        0  unknown  no
## 4438  2008-05-20      217        1    -1        0  unknown  no
## 4439  2008-05-20       68        1    -1        0  unknown  no
## 4440  2008-05-20      119        1    -1        0  unknown  no
## 4441  2008-05-20      160        1    -1        0  unknown  no
## 4442  2008-05-20      294       15    -1        0  unknown  no
## 4443  2008-05-20       57        1    -1        0  unknown  no
## 4444  2008-05-20       90        1    -1        0  unknown  no
## 4445  2008-05-20      600        1    -1        0  unknown  no
## 4446  2008-05-20      148        1    -1        0  unknown  no
## 4447  2008-05-20       38        1    -1        0  unknown  no
## 4448  2008-05-20      142        1    -1        0  unknown  no
## 4449  2008-05-20      466        1    -1        0  unknown  no
## 4450  2008-05-20       26        1    -1        0  unknown  no
## 4451  2008-05-20      203        2    -1        0  unknown  no
## 4452  2008-05-20      369        1    -1        0  unknown  no
## 4453  2008-05-20       29        1    -1        0  unknown  no
## 4454  2008-05-20      793        2    -1        0  unknown  no
## 4455  2008-05-20       71        1    -1        0  unknown  no
## 4456  2008-05-20      182        2    -1        0  unknown yes
## 4457  2008-05-20      203        1    -1        0  unknown  no
## 4458  2008-05-20      167        1    -1        0  unknown  no
## 4459  2008-05-20       37        1    -1        0  unknown  no
## 4460  2008-05-20       34        1    -1        0  unknown  no
## 4461  2008-05-20      394        1    -1        0  unknown  no
## 4462  2008-05-20      127        1    -1        0  unknown  no
## 4463  2008-05-20      264        1    -1        0  unknown  no
## 4464  2008-05-20      265        1    -1        0  unknown  no
## 4465  2008-05-20      231        1    -1        0  unknown  no
## 4466  2008-05-20      320        1    -1        0  unknown  no
## 4467  2008-05-20      101        1    -1        0  unknown  no
## 4468  2008-05-20      110        1    -1        0  unknown  no
## 4469  2008-05-20      121        3    -1        0  unknown  no
## 4470  2008-05-20      265        1    -1        0  unknown  no
## 4471  2008-05-20      345        1    -1        0  unknown  no
## 4472  2008-05-20      171        1    -1        0  unknown  no
## 4473  2008-05-20      572        1    -1        0  unknown  no
## 4474  2008-05-20       67        1    -1        0  unknown  no
## 4475  2008-05-20       25        1    -1        0  unknown  no
## 4476  2008-05-20      269        1    -1        0  unknown  no
## 4477  2008-05-20      132        1    -1        0  unknown  no
## 4478  2008-05-20      115        1    -1        0  unknown  no
## 4479  2008-05-20      273        1    -1        0  unknown  no
## 4480  2008-05-20       56        1    -1        0  unknown  no
## 4481  2008-05-20      434        1    -1        0  unknown  no
## 4482  2008-05-20      507        1    -1        0  unknown  no
## 4483  2008-05-20      253        1    -1        0  unknown  no
## 4484  2008-05-20      100        1    -1        0  unknown  no
## 4485  2008-05-20      116        1    -1        0  unknown  no
## 4486  2008-05-20      124        1    -1        0  unknown  no
## 4487  2008-05-20       66        2    -1        0  unknown  no
## 4488  2008-05-20      233        2    -1        0  unknown  no
## 4489  2008-05-20       90        1    -1        0  unknown  no
## 4490  2008-05-20      104        1    -1        0  unknown  no
## 4491  2008-05-20      187        1    -1        0  unknown  no
## 4492  2008-05-20       92        2    -1        0  unknown  no
## 4493  2008-05-20      423        1    -1        0  unknown  no
## 4494  2008-05-20      215        2    -1        0  unknown  no
## 4495  2008-05-20      209        1    -1        0  unknown  no
## 4496  2008-05-20      181        1    -1        0  unknown  no
## 4497  2008-05-20      201        1    -1        0  unknown  no
## 4498  2008-05-20       40        1    -1        0  unknown  no
## 4499  2008-05-20      317        1    -1        0  unknown  no
## 4500  2008-05-20      447        1    -1        0  unknown  no
## 4501  2008-05-20      137        1    -1        0  unknown  no
## 4502  2008-05-20      184        1    -1        0  unknown  no
## 4503  2008-05-20      121        1    -1        0  unknown  no
## 4504  2008-05-20      138        4    -1        0  unknown  no
## 4505  2008-05-20      207        6    -1        0  unknown  no
## 4506  2008-05-20      309        1    -1        0  unknown  no
## 4507  2008-05-20      214        1    -1        0  unknown  no
## 4508  2008-05-20      134        1    -1        0  unknown  no
## 4509  2008-05-20      284        1    -1        0  unknown  no
## 4510  2008-05-20     1777        1    -1        0  unknown yes
## 4511  2008-05-20      774        1    -1        0  unknown  no
## 4512  2008-05-20      265        1    -1        0  unknown  no
## 4513  2008-05-20       62        1    -1        0  unknown  no
## 4514  2008-05-20      247        2    -1        0  unknown  no
## 4515  2008-05-20       89        1    -1        0  unknown  no
## 4516  2008-05-20      318        3    -1        0  unknown  no
## 4517  2008-05-20      277        2    -1        0  unknown  no
## 4518  2008-05-20      135        1    -1        0  unknown  no
## 4519  2008-05-20      126        3    -1        0  unknown  no
## 4520  2008-05-20      411        1    -1        0  unknown  no
## 4521  2008-05-20       85        1    -1        0  unknown  no
## 4522  2008-05-20      100        1    -1        0  unknown  no
## 4523  2008-05-20       83        1    -1        0  unknown  no
## 4524  2008-05-20       71        3    -1        0  unknown  no
## 4525  2008-05-20      199        4    -1        0  unknown  no
## 4526  2008-05-20       47        1    -1        0  unknown  no
## 4527  2008-05-20      253        1    -1        0  unknown  no
## 4528  2008-05-20      244        1    -1        0  unknown  no
## 4529  2008-05-20      224        1    -1        0  unknown  no
## 4530  2008-05-20       56        1    -1        0  unknown  no
## 4531  2008-05-20      638        2    -1        0  unknown  no
## 4532  2008-05-20      311        1    -1        0  unknown  no
## 4533  2008-05-20       77        1    -1        0  unknown  no
## 4534  2008-05-20      177        1    -1        0  unknown  no
## 4535  2008-05-20      189        1    -1        0  unknown  no
## 4536  2008-05-20      152        1    -1        0  unknown  no
## 4537  2008-05-20      151        1    -1        0  unknown  no
## 4538  2008-05-20      217        1    -1        0  unknown  no
## 4539  2008-05-20       24        1    -1        0  unknown  no
## 4540  2008-05-20      212        1    -1        0  unknown  no
## 4541  2008-05-20      163        2    -1        0  unknown  no
## 4542  2008-05-20      473        2    -1        0  unknown  no
## 4543  2008-05-20       68        1    -1        0  unknown  no
## 4544  2008-05-20      485        1    -1        0  unknown  no
## 4545  2008-05-20      172        1    -1        0  unknown  no
## 4546  2008-05-20       77        2    -1        0  unknown  no
## 4547  2008-05-20      396        1    -1        0  unknown  no
## 4548  2008-05-20      274        2    -1        0  unknown  no
## 4549  2008-05-20       88        2    -1        0  unknown  no
## 4550  2008-05-20      129        2    -1        0  unknown  no
## 4551  2008-05-20      474        2    -1        0  unknown  no
## 4552  2008-05-20      268        2    -1        0  unknown  no
## 4553  2008-05-20      374        2    -1        0  unknown  no
## 4554  2008-05-20       72        5    -1        0  unknown  no
## 4555  2008-05-20       61        2    -1        0  unknown  no
## 4556  2008-05-20      205        2    -1        0  unknown  no
## 4557  2008-05-20      347        6    -1        0  unknown  no
## 4558  2008-05-20      355        1    -1        0  unknown  no
## 4559  2008-05-20      211        2    -1        0  unknown  no
## 4560  2008-05-20      211        1    -1        0  unknown  no
## 4561  2008-05-20       66       12    -1        0  unknown  no
## 4562  2008-05-20     1452       10    -1        0  unknown  no
## 4563  2008-05-20      341        1    -1        0  unknown  no
## 4564  2008-05-20       14        1    -1        0  unknown  no
## 4565  2008-05-20      610        2    -1        0  unknown  no
## 4566  2008-05-20      120        1    -1        0  unknown  no
## 4567  2008-05-20      407        1    -1        0  unknown  no
## 4568  2008-05-20      464        2    -1        0  unknown  no
## 4569  2008-05-20      547        7    -1        0  unknown  no
## 4570  2008-05-20      152        2    -1        0  unknown  no
## 4571  2008-05-20      522        1    -1        0  unknown  no
## 4572  2008-05-20      227        9    -1        0  unknown  no
## 4573  2008-05-20     1376        2    -1        0  unknown  no
## 4574  2008-05-20      134        5    -1        0  unknown  no
## 4575  2008-05-20       37        1    -1        0  unknown  no
## 4576  2008-05-20      360        1    -1        0  unknown  no
## 4577  2008-05-20       51        1    -1        0  unknown  no
## 4578  2008-05-20      834        6    -1        0  unknown  no
## 4579  2008-05-20      106        1    -1        0  unknown  no
## 4580  2008-05-20      194        1    -1        0  unknown  no
## 4581  2008-05-20      535        1    -1        0  unknown  no
## 4582  2008-05-20      236        2    -1        0  unknown  no
## 4583  2008-05-20      182        1    -1        0  unknown  no
## 4584  2008-05-20      296        1    -1        0  unknown  no
## 4585  2008-05-20      201        1    -1        0  unknown  no
## 4586  2008-05-20      281        1    -1        0  unknown  no
## 4587  2008-05-20      150        1    -1        0  unknown  no
## 4588  2008-05-20       79        1    -1        0  unknown  no
## 4589  2008-05-20      359        2    -1        0  unknown  no
## 4590  2008-05-20      332        2    -1        0  unknown  no
## 4591  2008-05-20      592        1    -1        0  unknown  no
## 4592  2008-05-20      166        1    -1        0  unknown  no
## 4593  2008-05-20      245        1    -1        0  unknown  no
## 4594  2008-05-20      138        8    -1        0  unknown  no
## 4595  2008-05-20      369        1    -1        0  unknown  no
## 4596  2008-05-20      158        1    -1        0  unknown  no
## 4597  2008-05-20      261        1    -1        0  unknown  no
## 4598  2008-05-20      131        1    -1        0  unknown  no
## 4599  2008-05-20      412        1    -1        0  unknown  no
## 4600  2008-05-20      121       11    -1        0  unknown  no
## 4601  2008-05-20      137        2    -1        0  unknown  no
## 4602  2008-05-20      216        2    -1        0  unknown  no
## 4603  2008-05-20      324        1    -1        0  unknown  no
## 4604  2008-05-20      235        2    -1        0  unknown  no
## 4605  2008-05-20      203        1    -1        0  unknown  no
## 4606  2008-05-20      697        2    -1        0  unknown  no
## 4607  2008-05-20      156        2    -1        0  unknown  no
## 4608  2008-05-20     1182        4    -1        0  unknown yes
## 4609  2008-05-20      170        2    -1        0  unknown  no
## 4610  2008-05-20      272        2    -1        0  unknown  no
## 4611  2008-05-20      132        1    -1        0  unknown  no
## 4612  2008-05-20      271        1    -1        0  unknown  no
## 4613  2008-05-20      378        3    -1        0  unknown  no
## 4614  2008-05-20      114        1    -1        0  unknown  no
## 4615  2008-05-20      107        1    -1        0  unknown  no
## 4616  2008-05-20      383        1    -1        0  unknown  no
## 4617  2008-05-20      185        1    -1        0  unknown  no
## 4618  2008-05-20      254        1    -1        0  unknown  no
## 4619  2008-05-20      717        1    -1        0  unknown  no
## 4620  2008-05-20      157        1    -1        0  unknown  no
## 4621  2008-05-20       85        2    -1        0  unknown  no
## 4622  2008-05-20      249        3    -1        0  unknown  no
## 4623  2008-05-20      309        2    -1        0  unknown  no
## 4624  2008-05-20      112        2    -1        0  unknown  no
## 4625  2008-05-20       98        1    -1        0  unknown  no
## 4626  2008-05-20      188        3    -1        0  unknown  no
## 4627  2008-05-20      148        1    -1        0  unknown  no
## 4628  2008-05-20      145        2    -1        0  unknown  no
## 4629  2008-05-20      415        2    -1        0  unknown  no
## 4630  2008-05-20      742        2    -1        0  unknown  no
## 4631  2008-05-20       37        9    -1        0  unknown  no
## 4632  2008-05-20      120        1    -1        0  unknown  no
## 4633  2008-05-20      185        2    -1        0  unknown  no
## 4634  2008-05-20      204        1    -1        0  unknown  no
## 4635  2008-05-20     1045        1    -1        0  unknown yes
## 4636  2008-05-20      205        2    -1        0  unknown  no
## 4637  2008-05-20       74        2    -1        0  unknown  no
## 4638  2008-05-20       51       26    -1        0  unknown  no
## 4639  2008-05-20      190        2    -1        0  unknown  no
## 4640  2008-05-20      325        3    -1        0  unknown  no
## 4641  2008-05-20      650        3    -1        0  unknown yes
## 4642  2008-05-20      148        2    -1        0  unknown  no
## 4643  2008-05-20      212        2    -1        0  unknown  no
## 4644  2008-05-20      625        2    -1        0  unknown  no
## 4645  2008-05-20      134        3    -1        0  unknown  no
## 4646  2008-05-20       97        8    -1        0  unknown  no
## 4647  2008-05-20      438        2    -1        0  unknown  no
## 4648  2008-05-20      999        3    -1        0  unknown  no
## 4649  2008-05-20      127        2    -1        0  unknown  no
## 4650  2008-05-20      446        2    -1        0  unknown  no
## 4651  2008-05-20      217        4    -1        0  unknown  no
## 4652  2008-05-20      169        1    -1        0  unknown  no
## 4653  2008-05-20      247        3    -1        0  unknown  no
## 4654  2008-05-20      140        1    -1        0  unknown  no
## 4655  2008-05-20       60        6    -1        0  unknown  no
## 4656  2008-05-20       99        1    -1        0  unknown  no
## 4657  2008-05-20       26       14    -1        0  unknown  no
## 4658  2008-05-20      128        6    -1        0  unknown  no
## 4659  2008-05-20      215        3    -1        0  unknown  no
## 4660  2008-05-20       64        1    -1        0  unknown  no
## 4661  2008-05-20       52       11    -1        0  unknown  no
## 4662  2008-05-20      413        2    -1        0  unknown  no
## 4663  2008-05-20      216        2    -1        0  unknown  no
## 4664  2008-05-20      292        1    -1        0  unknown  no
## 4665  2008-05-20      129        8    -1        0  unknown  no
## 4666  2008-05-20      201        4    -1        0  unknown  no
## 4667  2008-05-20      210        2    -1        0  unknown  no
## 4668  2008-05-20      114        1    -1        0  unknown  no
## 4669  2008-05-20      657        1    -1        0  unknown  no
## 4670  2008-05-20       88        1    -1        0  unknown  no
## 4671  2008-05-20      147        2    -1        0  unknown  no
## 4672  2008-05-20      443        1    -1        0  unknown  no
## 4673  2008-05-20       73        1    -1        0  unknown  no
## 4674  2008-05-20      134        1    -1        0  unknown  no
## 4675  2008-05-20      127        8    -1        0  unknown  no
## 4676  2008-05-20     1063        2    -1        0  unknown yes
## 4677  2008-05-20      446        2    -1        0  unknown  no
## 4678  2008-05-20      144        2    -1        0  unknown  no
## 4679  2008-05-20      196        6    -1        0  unknown  no
## 4680  2008-05-20      165        2    -1        0  unknown  no
## 4681  2008-05-20      314        2    -1        0  unknown  no
## 4682  2008-05-20      723        2    -1        0  unknown  no
## 4683  2008-05-20     1410        2    -1        0  unknown yes
## 4684  2008-05-20      550        2    -1        0  unknown  no
## 4685  2008-05-20      130        2    -1        0  unknown  no
## 4686  2008-05-20      307        3    -1        0  unknown  no
## 4687  2008-05-20      146        2    -1        0  unknown  no
## 4688  2008-05-20      239        2    -1        0  unknown  no
## 4689  2008-05-20      304        2    -1        0  unknown  no
## 4690  2008-05-20      114        3    -1        0  unknown  no
## 4691  2008-05-20      445        2    -1        0  unknown  no
## 4692  2008-05-20      139        5    -1        0  unknown  no
## 4693  2008-05-20       16       10    -1        0  unknown  no
## 4694  2008-05-20      169        4    -1        0  unknown  no
## 4695  2008-05-20      125        3    -1        0  unknown  no
## 4696  2008-05-20      446       12    -1        0  unknown  no
## 4697  2008-05-20      267        2    -1        0  unknown  no
## 4698  2008-05-20        6        2    -1        0  unknown  no
## 4699  2008-05-20       15       13    -1        0  unknown  no
## 4700  2008-05-20     1287        2    -1        0  unknown  no
## 4701  2008-05-20      172        4    -1        0  unknown  no
## 4702  2008-05-20      268        3    -1        0  unknown  no
## 4703  2008-05-20       89        3    -1        0  unknown  no
## 4704  2008-05-20      102        2    -1        0  unknown  no
## 4705  2008-05-20       91        6    -1        0  unknown  no
## 4706  2008-05-20      465        8    -1        0  unknown  no
## 4707  2008-05-20      274        2    -1        0  unknown  no
## 4708  2008-05-20      191        7    -1        0  unknown  no
## 4709  2008-05-20      300        3    -1        0  unknown  no
## 4710  2008-05-20      236        2    -1        0  unknown  no
## 4711  2008-05-20      614        2    -1        0  unknown  no
## 4712  2008-05-20      363        5    -1        0  unknown  no
## 4713  2008-05-20      418        2    -1        0  unknown  no
## 4714  2008-05-20      229        2    -1        0  unknown  no
## 4715  2008-05-20      221        2    -1        0  unknown  no
## 4716  2008-05-20      130        2    -1        0  unknown  no
## 4717  2008-05-20       96        2    -1        0  unknown  no
## 4718  2008-05-20      119        3    -1        0  unknown  no
## 4719  2008-05-20      103        3    -1        0  unknown  no
## 4720  2008-05-20      843        2    -1        0  unknown yes
## 4721  2008-05-20      484        2    -1        0  unknown  no
## 4722  2008-05-20      485        3    -1        0  unknown  no
## 4723  2008-05-20      175        2    -1        0  unknown  no
## 4724  2008-05-20      138        2    -1        0  unknown  no
## 4725  2008-05-20      243        2    -1        0  unknown  no
## 4726  2008-05-20      919        2    -1        0  unknown  no
## 4727  2008-05-20      203        2    -1        0  unknown  no
## 4728  2008-05-20      247        2    -1        0  unknown  no
## 4729  2008-05-20       89        2    -1        0  unknown  no
## 4730  2008-05-20      185       12    -1        0  unknown  no
## 4731  2008-05-20      777        3    -1        0  unknown  no
## 4732  2008-05-20      340        3    -1        0  unknown  no
## 4733  2008-05-20      135        2    -1        0  unknown  no
## 4734  2008-05-20      241        3    -1        0  unknown  no
## 4735  2008-05-20      165        2    -1        0  unknown  no
## 4736  2008-05-20       26        2    -1        0  unknown  no
## 4737  2008-05-20      109        6    -1        0  unknown  no
## 4738  2008-05-20      350        4    -1        0  unknown  no
## 4739  2008-05-20       51        7    -1        0  unknown  no
## 4740  2008-05-20      226        2    -1        0  unknown  no
## 4741  2008-05-20       47        3    -1        0  unknown  no
## 4742  2008-05-20      167        2    -1        0  unknown  no
## 4743  2008-05-20      214       10    -1        0  unknown  no
## 4744  2008-05-20      446        7    -1        0  unknown  no
## 4745  2008-05-20      414        2    -1        0  unknown  no
## 4746  2008-05-20      153        2    -1        0  unknown  no
## 4747  2008-05-20      181        6    -1        0  unknown  no
## 4748  2008-05-20      747        5    -1        0  unknown  no
## 4749  2008-05-20      214        1    -1        0  unknown  no
## 4750  2008-05-20      270        1    -1        0  unknown  no
## 4751  2008-05-20       37       13    -1        0  unknown  no
## 4752  2008-05-20      129        8    -1        0  unknown  no
## 4753  2008-05-20       72        3    -1        0  unknown  no
## 4754  2008-05-20     1392        2    -1        0  unknown yes
## 4755  2008-05-20      725        1    -1        0  unknown  no
## 4756  2008-05-20      213        3    -1        0  unknown  no
## 4757  2008-05-20      177       10    -1        0  unknown  no
## 4758  2008-05-20      273        4    -1        0  unknown  no
## 4759  2008-05-20      480        4    -1        0  unknown  no
## 4760  2008-05-20      152        1    -1        0  unknown  no
## 4761  2008-05-20      204        2    -1        0  unknown  no
## 4762  2008-05-20      246        3    -1        0  unknown  no
## 4763  2008-05-20      352        5    -1        0  unknown  no
## 4764  2008-05-20      190        1    -1        0  unknown  no
## 4765  2008-05-20      140        1    -1        0  unknown  no
## 4766  2008-05-20      719        1    -1        0  unknown yes
## 4767  2008-05-20      315        1    -1        0  unknown  no
## 4768  2008-05-21      225        1    -1        0  unknown  no
## 4769  2008-05-21       74        1    -1        0  unknown  no
## 4770  2008-05-21       24        1    -1        0  unknown  no
## 4771  2008-05-21      369        1    -1        0  unknown  no
## 4772  2008-05-21      167        1    -1        0  unknown  no
## 4773  2008-05-21       64        3    -1        0  unknown  no
## 4774  2008-05-21      151        1    -1        0  unknown  no
## 4775  2008-05-21      336        1    -1        0  unknown  no
## 4776  2008-05-21       65        1    -1        0  unknown  no
## 4777  2008-05-21       93        1    -1        0  unknown  no
## 4778  2008-05-21      181        1    -1        0  unknown  no
## 4779  2008-05-21       86        6    -1        0  unknown  no
## 4780  2008-05-21      317        1    -1        0  unknown  no
## 4781  2008-05-21      120        1    -1        0  unknown  no
## 4782  2008-05-21      388        1    -1        0  unknown  no
## 4783  2008-05-21      422        2    -1        0  unknown  no
## 4784  2008-05-21      174        1    -1        0  unknown  no
## 4785  2008-05-21       72        1    -1        0  unknown  no
## 4786  2008-05-21      126        1    -1        0  unknown  no
## 4787  2008-05-21      288        1    -1        0  unknown  no
## 4788  2008-05-21      339        1    -1        0  unknown  no
## 4789  2008-05-21      171        5    -1        0  unknown  no
## 4790  2008-05-21      162        1    -1        0  unknown  no
## 4791  2008-05-21       18       28    -1        0  unknown  no
## 4792  2008-05-21      129        1    -1        0  unknown  no
## 4793  2008-05-21      173        1    -1        0  unknown  no
## 4794  2008-05-21       74        1    -1        0  unknown  no
## 4795  2008-05-21      222        1    -1        0  unknown  no
## 4796  2008-05-21      692        1    -1        0  unknown  no
## 4797  2008-05-21      262        2    -1        0  unknown  no
## 4798  2008-05-21       78        1    -1        0  unknown  no
## 4799  2008-05-21      134        5    -1        0  unknown  no
## 4800  2008-05-21      323        1    -1        0  unknown  no
## 4801  2008-05-21       43        1    -1        0  unknown  no
## 4802  2008-05-21      245        1    -1        0  unknown  no
## 4803  2008-05-21      482        1    -1        0  unknown  no
## 4804  2008-05-21      207        2    -1        0  unknown  no
## 4805  2008-05-21       56        1    -1        0  unknown  no
## 4806  2008-05-21      201        1    -1        0  unknown  no
## 4807  2008-05-21      353        1    -1        0  unknown  no
## 4808  2008-05-21      554        3    -1        0  unknown  no
## 4809  2008-05-21      432        1    -1        0  unknown  no
## 4810  2008-05-21       27        2    -1        0  unknown  no
## 4811  2008-05-21      361        1    -1        0  unknown  no
## 4812  2008-05-21      248        1    -1        0  unknown  no
## 4813  2008-05-21      162        1    -1        0  unknown  no
## 4814  2008-05-21      565        1    -1        0  unknown yes
## 4815  2008-05-21      139        1    -1        0  unknown  no
## 4816  2008-05-21      147        1    -1        0  unknown  no
## 4817  2008-05-21      287        3    -1        0  unknown  no
## 4818  2008-05-21      118        1    -1        0  unknown  no
## 4819  2008-05-21      905        1    -1        0  unknown yes
## 4820  2008-05-21       91        1    -1        0  unknown  no
## 4821  2008-05-21      111        5    -1        0  unknown  no
## 4822  2008-05-21      162        1    -1        0  unknown  no
## 4823  2008-05-21      236        1    -1        0  unknown  no
## 4824  2008-05-21      253        3    -1        0  unknown  no
## 4825  2008-05-21       73        1    -1        0  unknown  no
## 4826  2008-05-21      123        1    -1        0  unknown  no
## 4827  2008-05-21      298        2    -1        0  unknown  no
## 4828  2008-05-21       86        1    -1        0  unknown  no
## 4829  2008-05-21      420        1    -1        0  unknown  no
## 4830  2008-05-21      288        1    -1        0  unknown  no
## 4831  2008-05-21      164        1    -1        0  unknown  no
## 4832  2008-05-21      195        1    -1        0  unknown  no
## 4833  2008-05-21      139        1    -1        0  unknown  no
## 4834  2008-05-21      192        1    -1        0  unknown  no
## 4835  2008-05-21      226        1    -1        0  unknown  no
## 4836  2008-05-21      783        2    -1        0  unknown yes
## 4837  2008-05-21      264        2    -1        0  unknown  no
## 4838  2008-05-21      166        1    -1        0  unknown  no
## 4839  2008-05-21       27        1    -1        0  unknown  no
## 4840  2008-05-21      353        1    -1        0  unknown  no
## 4841  2008-05-21      282        2    -1        0  unknown  no
## 4842  2008-05-21      117        1    -1        0  unknown  no
## 4843  2008-05-21       85        1    -1        0  unknown  no
## 4844  2008-05-21     1106        1    -1        0  unknown  no
## 4845  2008-05-21      419        1    -1        0  unknown  no
## 4846  2008-05-21       32       11    -1        0  unknown  no
## 4847  2008-05-21      179        1    -1        0  unknown  no
## 4848  2008-05-21      872        5    -1        0  unknown  no
## 4849  2008-05-21      114        1    -1        0  unknown  no
## 4850  2008-05-21       52        1    -1        0  unknown  no
## 4851  2008-05-21      490        1    -1        0  unknown  no
## 4852  2008-05-21       63        1    -1        0  unknown  no
## 4853  2008-05-21       27       10    -1        0  unknown  no
## 4854  2008-05-21      425        1    -1        0  unknown  no
## 4855  2008-05-21      189        2    -1        0  unknown  no
## 4856  2008-05-21       12       11    -1        0  unknown  no
## 4857  2008-05-21      255        1    -1        0  unknown  no
## 4858  2008-05-21      103        1    -1        0  unknown  no
## 4859  2008-05-21      210        1    -1        0  unknown  no
## 4860  2008-05-21      261        1    -1        0  unknown  no
## 4861  2008-05-21      115        2    -1        0  unknown  no
## 4862  2008-05-21      641        1    -1        0  unknown  no
## 4863  2008-05-21       83        1    -1        0  unknown  no
## 4864  2008-05-21      370        1    -1        0  unknown  no
## 4865  2008-05-21      287        1    -1        0  unknown  no
## 4866  2008-05-21      103        2    -1        0  unknown  no
## 4867  2008-05-21      958        2    -1        0  unknown yes
## 4868  2008-05-21      232        1    -1        0  unknown  no
## 4869  2008-05-21       68        1    -1        0  unknown  no
## 4870  2008-05-21      192        1    -1        0  unknown  no
## 4871  2008-05-21      494        3    -1        0  unknown  no
## 4872  2008-05-21      166        7    -1        0  unknown  no
## 4873  2008-05-21      151        2    -1        0  unknown  no
## 4874  2008-05-21      204        1    -1        0  unknown  no
## 4875  2008-05-21      217        1    -1        0  unknown  no
## 4876  2008-05-21      180        1    -1        0  unknown  no
## 4877  2008-05-21      494        2    -1        0  unknown  no
## 4878  2008-05-21      530        2    -1        0  unknown  no
## 4879  2008-05-21      759        1    -1        0  unknown  no
## 4880  2008-05-21       85        1    -1        0  unknown  no
## 4881  2008-05-21      137        2    -1        0  unknown  no
## 4882  2008-05-21      445        2    -1        0  unknown  no
## 4883  2008-05-21      345        1    -1        0  unknown  no
## 4884  2008-05-21       16        1    -1        0  unknown  no
## 4885  2008-05-21       32        1    -1        0  unknown  no
## 4886  2008-05-21      648        1    -1        0  unknown  no
## 4887  2008-05-21       29        1    -1        0  unknown  no
## 4888  2008-05-21      220        1    -1        0  unknown  no
## 4889  2008-05-21      151        1    -1        0  unknown  no
## 4890  2008-05-21      290        2    -1        0  unknown  no
## 4891  2008-05-21      121        1    -1        0  unknown  no
## 4892  2008-05-21      717        3    -1        0  unknown  no
## 4893  2008-05-21      249        1    -1        0  unknown  no
## 4894  2008-05-21      228        1    -1        0  unknown  no
## 4895  2008-05-21      122        1    -1        0  unknown  no
## 4896  2008-05-21      544        1    -1        0  unknown  no
## 4897  2008-05-21      951        2    -1        0  unknown  no
## 4898  2008-05-21      412        1    -1        0  unknown yes
## 4899  2008-05-21      211        1    -1        0  unknown  no
## 4900  2008-05-21      264        1    -1        0  unknown  no
## 4901  2008-05-21       97        1    -1        0  unknown  no
## 4902  2008-05-21      160        1    -1        0  unknown  no
## 4903  2008-05-21      192        1    -1        0  unknown  no
## 4904  2008-05-21      230        1    -1        0  unknown  no
## 4905  2008-05-21       97        1    -1        0  unknown  no
## 4906  2008-05-21      578        2    -1        0  unknown  no
## 4907  2008-05-21      359        1    -1        0  unknown  no
## 4908  2008-05-21      244        1    -1        0  unknown  no
## 4909  2008-05-21      111        1    -1        0  unknown  no
## 4910  2008-05-21      487        5    -1        0  unknown  no
## 4911  2008-05-21      311        1    -1        0  unknown  no
## 4912  2008-05-21      396        1    -1        0  unknown  no
## 4913  2008-05-21       59        8    -1        0  unknown  no
## 4914  2008-05-21      111        3    -1        0  unknown  no
## 4915  2008-05-21      502        1    -1        0  unknown  no
## 4916  2008-05-21      202        6    -1        0  unknown  no
## 4917  2008-05-21      795        1    -1        0  unknown yes
## 4918  2008-05-21      135        1    -1        0  unknown  no
## 4919  2008-05-21       29        1    -1        0  unknown  no
## 4920  2008-05-21      136        1    -1        0  unknown  no
## 4921  2008-05-21      103        2    -1        0  unknown  no
## 4922  2008-05-21      171        1    -1        0  unknown  no
## 4923  2008-05-21      229        2    -1        0  unknown  no
## 4924  2008-05-21      112        2    -1        0  unknown  no
## 4925  2008-05-21       93        1    -1        0  unknown  no
## 4926  2008-05-21       61        1    -1        0  unknown  no
## 4927  2008-05-21       35        1    -1        0  unknown  no
## 4928  2008-05-21        7       12    -1        0  unknown  no
## 4929  2008-05-21       51        2    -1        0  unknown  no
## 4930  2008-05-21       17        7    -1        0  unknown  no
## 4931  2008-05-21      504        1    -1        0  unknown  no
## 4932  2008-05-21      726        1    -1        0  unknown  no
## 4933  2008-05-21      542        1    -1        0  unknown  no
## 4934  2008-05-21      226        1    -1        0  unknown  no
## 4935  2008-05-21      153        1    -1        0  unknown  no
## 4936  2008-05-21      112        1    -1        0  unknown  no
## 4937  2008-05-21      158        2    -1        0  unknown  no
## 4938  2008-05-21      250        2    -1        0  unknown  no
## 4939  2008-05-21      294        2    -1        0  unknown  no
## 4940  2008-05-21      303        3    -1        0  unknown  no
## 4941  2008-05-21      343        1    -1        0  unknown  no
## 4942  2008-05-21      828        4    -1        0  unknown yes
## 4943  2008-05-21      206        1    -1        0  unknown  no
## 4944  2008-05-21      786        2    -1        0  unknown  no
## 4945  2008-05-21      509        1    -1        0  unknown  no
## 4946  2008-05-21      161        4    -1        0  unknown  no
## 4947  2008-05-21      125        3    -1        0  unknown  no
## 4948  2008-05-21       63        2    -1        0  unknown  no
## 4949  2008-05-21      649        2    -1        0  unknown yes
## 4950  2008-05-21      159        1    -1        0  unknown  no
## 4951  2008-05-21      211        1    -1        0  unknown  no
## 4952  2008-05-21       68        1    -1        0  unknown  no
## 4953  2008-05-21      293        1    -1        0  unknown  no
## 4954  2008-05-21      389        1    -1        0  unknown  no
## 4955  2008-05-21      240        1    -1        0  unknown  no
## 4956  2008-05-21      145        1    -1        0  unknown  no
## 4957  2008-05-21       59        2    -1        0  unknown  no
## 4958  2008-05-21       39        2    -1        0  unknown  no
## 4959  2008-05-21      272        2    -1        0  unknown  no
## 4960  2008-05-21      140        2    -1        0  unknown  no
## 4961  2008-05-21       53        3    -1        0  unknown  no
## 4962  2008-05-21       44        3    -1        0  unknown  no
## 4963  2008-05-21      212        2    -1        0  unknown  no
## 4964  2008-05-21       57        2    -1        0  unknown  no
## 4965  2008-05-21       45       13    -1        0  unknown  no
## 4966  2008-05-21      738        3    -1        0  unknown  no
## 4967  2008-05-21      102        3    -1        0  unknown  no
## 4968  2008-05-21      161        2    -1        0  unknown  no
## 4969  2008-05-21      383        2    -1        0  unknown  no
## 4970  2008-05-21     1091        3    -1        0  unknown  no
## 4971  2008-05-21      122        2    -1        0  unknown  no
## 4972  2008-05-21      137        2    -1        0  unknown  no
## 4973  2008-05-21      189        2    -1        0  unknown  no
## 4974  2008-05-21       88        2    -1        0  unknown  no
## 4975  2008-05-21      364        1    -1        0  unknown  no
## 4976  2008-05-21      418        2    -1        0  unknown  no
## 4977  2008-05-21       17        2    -1        0  unknown  no
## 4978  2008-05-21      233        1    -1        0  unknown  no
## 4979  2008-05-21      373        2    -1        0  unknown  no
## 4980  2008-05-21      445        1    -1        0  unknown  no
## 4981  2008-05-21      623        1    -1        0  unknown  no
## 4982  2008-05-21      260        1    -1        0  unknown  no
## 4983  2008-05-21      316        1    -1        0  unknown  no
## 4984  2008-05-21       42        1    -1        0  unknown  no
## 4985  2008-05-21      650        2    -1        0  unknown  no
## 4986  2008-05-21      207        1    -1        0  unknown  no
## 4987  2008-05-21      226        1    -1        0  unknown  no
## 4988  2008-05-21     1307        1    -1        0  unknown  no
## 4989  2008-05-21      104        1    -1        0  unknown  no
## 4990  2008-05-21      143        1    -1        0  unknown  no
## 4991  2008-05-21      187        5    -1        0  unknown  no
## 4992  2008-05-21      748        1    -1        0  unknown  no
## 4993  2008-05-21      486        2    -1        0  unknown  no
## 4994  2008-05-21      492        1    -1        0  unknown  no
## 4995  2008-05-21      485        1    -1        0  unknown  no
## 4996  2008-05-21      110        2    -1        0  unknown  no
## 4997  2008-05-21      304        1    -1        0  unknown  no
## 4998  2008-05-21       51        2    -1        0  unknown  no
## 4999  2008-05-21      836       12    -1        0  unknown  no
##  [ reached getOption("max.print") -- omitted 40212 rows ]
```

When the class of data object is not tbl, `tbl_df()` function should be used:


```r
# Example of data frame
df <- setNames(object = data.frame(matrix(data = runif(2000), nrow = 100, ncol = 20)),
               nm = letters[1:20])
class(df)
```

```
## [1] "data.frame"
```

```r
head(df)
```

```
##            a          b         c         d         e         f         g         h          i            j
## 1 0.25767250 0.38947869 0.9563228 0.6532260 0.2777107 0.7431595 0.5797055 0.6945936 0.22993408 0.2910003348
## 2 0.55232243 0.04105275 0.9135767 0.9508858 0.3606569 0.3059573 0.1542048 0.9028108 0.44362621 0.0004488295
## 3 0.05638315 0.36139663 0.8233363 0.6172230 0.4375279 0.4022088 0.1252705 0.0294742 0.51570490 0.6454668748
## 4 0.46854928 0.57097808 0.3194822 0.4928406 0.8030667 0.3935714 0.1479858 0.4718077 0.92489425 0.8269246418
## 5 0.48377074 0.68488024 0.8777003 0.9760066 0.5206097 0.4407565 0.9133426 0.4088902 0.04445684 0.7549124290
## 6 0.81240262 0.97111675 0.8003510 0.4903452 0.6961521 0.7728051 0.2574304 0.3369403 0.14915658 0.5148178525
##           k         l         m          n         o         p         q           r         s          t
## 1 0.1118664 0.8073436 0.7717425 0.60821168 0.2022793 0.4044626 0.2294918 0.826253708 0.4786617 0.45232278
## 2 0.6239440 0.7024703 0.4949800 0.04605777 0.5222016 0.3549295 0.9693079 0.971815727 0.3072272 0.28517984
## 3 0.6710818 0.7994766 0.3926061 0.56928747 0.8133963 0.2244061 0.1315974 0.003214312 0.8855426 0.62280540
## 4 0.3658942 0.5308012 0.1053059 0.30627200 0.9161582 0.6823570 0.6090285 0.758520066 0.5418244 0.06516503
## 5 0.1831814 0.4601550 0.3560706 0.84120096 0.9463884 0.3391498 0.2840458 0.496161843 0.4221332 0.55112740
## 6 0.0267197 0.1527191 0.7807699 0.09852506 0.8134322 0.4753990 0.2635943 0.246452654 0.1191685 0.88244969
```

```r
# dplyr version of the same data frame
dfd <- tbl_df(df)
class(dfd)
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

```r
dfd
```

```
## Source: local data frame [100 x 20]
## 
##             a          b          c         d         e         f         g          h          i
##         (dbl)      (dbl)      (dbl)     (dbl)     (dbl)     (dbl)     (dbl)      (dbl)      (dbl)
## 1  0.25767250 0.38947869 0.95632284 0.6532260 0.2777107 0.7431595 0.5797055 0.69459356 0.22993408
## 2  0.55232243 0.04105275 0.91357666 0.9508858 0.3606569 0.3059573 0.1542048 0.90281083 0.44362621
## 3  0.05638315 0.36139663 0.82333634 0.6172230 0.4375279 0.4022088 0.1252705 0.02947420 0.51570490
## 4  0.46854928 0.57097808 0.31948216 0.4928406 0.8030667 0.3935714 0.1479858 0.47180772 0.92489425
## 5  0.48377074 0.68488024 0.87770033 0.9760066 0.5206097 0.4407565 0.9133426 0.40889021 0.04445684
## 6  0.81240262 0.97111675 0.80035100 0.4903452 0.6961521 0.7728051 0.2574304 0.33694027 0.14915658
## 7  0.37032054 0.70195881 0.61135664 0.6551723 0.8478369 0.2095690 0.5424653 0.66327555 0.84817388
## 8  0.54655860 0.01154550 0.07242114 0.5988018 0.8457093 0.7481227 0.6490225 0.87313585 0.15295591
## 9  0.17026205 0.53553213 0.42158771 0.9475690 0.3918757 0.5853552 0.1491944 0.08675941 0.82496680
## 10 0.62499648 0.83657146 0.34446560 0.3680115 0.1535138 0.3244472 0.8489404 0.33464360 0.86319212
## ..        ...        ...        ...       ...       ...       ...       ...        ...        ...
## Variables not shown: j (dbl), k (dbl), l (dbl), m (dbl), n (dbl), o (dbl), p (dbl), q (dbl), r (dbl), s
##   (dbl), t (dbl)
```


# Verb functions

`dplyr` aims to provide a function for each basic verb of data manipulating.

All these functions are very similar:

* the first argument is a data frame;
* the subsequent arguments describe what to do with it, and you can refer to columns in the data frame directly without using $;
* the result is a new data frame.

Together these properties make it easy to chain together multiple simple steps to achieve a complex result.

These five functions provide the basis of a language of data manipulation. At the most basic level, you can only alter a tidy data frame in five useful ways: 

1. select variables of interest: `select()`;
2. filter records of interest: `filter()`;
3. reorder the rows: `arrange()`;
4. add new variables that are functions of existing variables: `mutate()`;
5. collapse many values to a summary: `summarise()`. 

The remainder of the language comes from applying these five functions to different types of data, like grouped data, which will be described after.
