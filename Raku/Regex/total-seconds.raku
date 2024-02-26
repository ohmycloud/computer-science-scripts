sub MAIN(:$file) {
    my @lines = $file.IO.lines;
    my @res = gather for @lines -> $line {
        my @t = $line.comb(/(\d+)/);
    
        given $line {
            when /^\d+小时\d+分\d+秒$/ { take @t[0] * 3600 + @t[1] * 60 + @t[2] }
            when /^\d+小时\d+分$/      { take @t[0] * 3600 + @t[1] * 60         }
            when /^\d+小时\d+秒$/      { take @t[0] * 3600 + @t[1]              }
            when /^\d+小时$/           { take @t[0] * 3600                      }
            when /^\d+分\d+秒$/        { take @t[0] * 60 + @t[1]                }
            when /^\d+分$/             { take @t[0] * 60                        }
            when /^\d+秒$/             { take @t[0]                             }
            default                    { take 0                                 }
        }
    }
    .say for @res;
}

# 46分49秒
# 36分49秒
# 1小时9分30秒
