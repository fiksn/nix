{
  activesupport = {
    dependencies = ["concurrent-ruby" "i18n" "minitest" "tzinfo" "zeitwerk"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l29n9n38c9lpy5smh26r7fy7jp2bpjqlzhxgsr79cv7xpwlrbhs";
      type = "gem";
    };
    version = "6.0.3.1";
  };
  attribute_struct = {
    dependencies = ["bogo"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1sar9blf0lw04m1i54yqf3f3g6w9skr4l0lxcyvk1xs48frlaibb";
      type = "gem";
    };
    version = "0.4.4";
  };
  aws-eventstream = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0r0pn66yqrdkrfdin7qdim0yj2x75miyg4wp6mijckhzhrjb7cv5";
      type = "gem";
    };
    version = "1.1.0";
  };
  aws-partitions = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1mryhkcnq3kih2m814vjwpyw9l9bh58phqzq4xh60pblsf5x8hyh";
      type = "gem";
    };
    version = "1.321.0";
  };
  aws-sdk-acm = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l188z7dn1y0sjmkfvdli7f8d51hrdvx5s2kajhqgwp14g9ylsja";
      type = "gem";
    };
    version = "1.30.0";
  };
  aws-sdk-cloudformation = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x1h9b513rkyii44pnjhxg8367mr2i8r0qqfsc3a0kmgafww12zm";
      type = "gem";
    };
    version = "1.35.0";
  };
  aws-sdk-core = {
    dependencies = ["aws-eventstream" "aws-partitions" "aws-sigv4" "jmespath"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jdnzynjrpp2jyg8vrbfbaad16k8ni1520xah1z2ckl5779x9fi6";
      type = "gem";
    };
    version = "3.96.1";
  };
  aws-sdk-ec2 = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0pk13p9bndgfhyv68srizrra7lqywsbf4gqjh7izb2zq565q81m3";
      type = "gem";
    };
    version = "1.163.0";
  };
  aws-sdk-ecr = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zg2g7fx560bgz768d7dxisyx32j96pvd5axwwmyqkf6dhaqgzka";
      type = "gem";
    };
    version = "1.29.0";
  };
  aws-sdk-iam = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09l3g5a2r7gnc6pwln409b9ahwcs6xpnjx2qaj70cbllanyxbw0c";
      type = "gem";
    };
    version = "1.37.0";
  };
  aws-sdk-kms = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1czxr6yi8p9gma4dwgygp1jn0i289hwa2vw69kzfscgbn118c3mm";
      type = "gem";
    };
    version = "1.31.0";
  };
  aws-sdk-s3 = {
    dependencies = ["aws-sdk-core" "aws-sdk-kms" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x1d1azxwanvm0d7qppw41x5nx2zv0bcz41yk9vqi5lvr7apaq13";
      type = "gem";
    };
    version = "1.66.0";
  };
  aws-sdk-sns = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17zyrg2z0wpaqgv4l3mvqb7vbdya116w5yx4353xg99f7j713hiq";
      type = "gem";
    };
    version = "1.23.0";
  };
  aws-sdk-ssm = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1y6bkyvhn08h8smxr49x02x6w4s54xgpb3w379a5hqnmna67axyl";
      type = "gem";
    };
    version = "1.78.0";
  };
  aws-sigv4 = {
    dependencies = ["aws-eventstream"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0kysxyw1zkvggbmcj4xnscdh15kxli8mx07hv447h74g9x02drsd";
      type = "gem";
    };
    version = "1.1.3";
  };
  bogo = {
    dependencies = ["concurrent-ruby" "hashie" "multi_json"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mfshglgrwx8bq5pj3w6ypajfz92j0wis1i339bkd8ligvliq7yb";
      type = "gem";
    };
    version = "0.2.14";
  };
  cfndsl = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10mvdhgy22kvqp5lfaplp8f5lw87gr3asw4cvqp1g44grsi4p9r6";
      type = "gem";
    };
    version = "0.17.5";
  };
  commander = {
    dependencies = ["highline"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "134g4nk886dm6lpjp3lbr5a4j8hamsdll5cxjazvpkz93fq4c1rc";
      type = "gem";
    };
    version = "4.5.2";
  };
  concurrent-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "094387x4yasb797mv07cs3g6f08y56virc2rjcpb1k79rzaj3nhl";
      type = "gem";
    };
    version = "1.1.6";
  };
  deep_merge = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1q3picw7zx1xdkybmrnhmk2hycxzaa0jv4gqrby1s90dy5n7fmsb";
      type = "gem";
    };
    version = "1.2.1";
  };
  diff-lcs = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "18w22bjz424gzafv6nzv98h0aqkwz3d9xhm7cbr1wfbyas8zayza";
      type = "gem";
    };
    version = "1.3";
  };
  diffy = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qhx743lcx61r2d3925jk61c6r8clfjmpf5g93cdy5sq00ig76lh";
      type = "gem";
    };
    version = "3.3.0";
  };
  ejson = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "11w3b9izim0ss77rypzn0fad4h5kzc329sf8g4mw4lrd7xbrnkjy";
      type = "gem";
    };
    version = "1.2.1";
  };
  ejson_wrapper = {
    dependencies = ["aws-sdk-kms" "ejson"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06lvjm64s59p7cjvbzw90kv4wnw2xgz4jr5zk8knzmbg2hi1wn76";
      type = "gem";
    };
    version = "0.4.0";
  };
  erubis = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fj827xqjs91yqsydf0zmfyw9p4l2jz5yikg3mppz6d7fi8kyrb3";
      type = "gem";
    };
    version = "2.7.0";
  };
  hashdiff = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nynpl0xbj0nphqx1qlmyggq58ms1phf5i03hk64wcc0a17x1m1c";
      type = "gem";
    };
    version = "1.0.1";
  };
  hashie = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02bsx12ihl78x0vdm37byp78jjw2ff6035y7rrmbd90qxjwxr43q";
      type = "gem";
    };
    version = "4.1.0";
  };
  highline = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yclf57n2j3cw8144ania99h1zinf8q3f5zrhqa754j6gl95rp9d";
      type = "gem";
    };
    version = "2.0.3";
  };
  i18n = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0jwrd1l4mxz06iyx6053lr6hz2zy7ah2k3ranfzisvych5q19kwm";
      type = "gem";
    };
    version = "1.8.2";
  };
  jmespath = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1d4wac0dcd1jf6kc57891glih9w57552zgqswgy74d1xhgnk0ngf";
      type = "gem";
    };
    version = "1.4.0";
  };
  minitest = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09bz9nsznxgaf06cx3b5z71glgl0hdw469gqx3w7bqijgrb55p5g";
      type = "gem";
    };
    version = "5.14.1";
  };
  multi_json = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xy54mjf7xg41l8qrg1bqri75agdqmxap9z466fjismc1rn2jwfr";
      type = "gem";
    };
    version = "1.14.1";
  };
  os = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xnynckvrn9ailkmkrmkldnpv8hmmbdwxr7c7iz27cl1cpcdd49n";
      type = "gem";
    };
    version = "1.1.0";
  };
  rainbow = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bb2fpjspydr6x0s8pn1pqkzmxszvkfapv0p4627mywl7ky4zkhk";
      type = "gem";
    };
    version = "3.0.0";
  };
  ruby-progressbar = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1k77i0d4wsn23ggdd2msrcwfy0i376cglfqypkk2q77r2l3408zf";
      type = "gem";
    };
    version = "1.10.1";
  };
  sparkle_formation = {
    dependencies = ["attribute_struct" "bogo" "multi_json"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "179clm0gzyqv339q3iwsqvb17gwsiqjjnfd5rmqnn3m071manlgk";
      type = "gem";
    };
    version = "3.0.40";
  };
  stack_master = {
    dependencies = ["activesupport" "aws-sdk-acm" "aws-sdk-cloudformation" "aws-sdk-ec2" "aws-sdk-ecr" "aws-sdk-iam" "aws-sdk-s3" "aws-sdk-sns" "aws-sdk-ssm" "cfndsl" "commander" "deep_merge" "diff-lcs" "diffy" "ejson_wrapper" "erubis" "hashdiff" "multi_json" "os" "rainbow" "ruby-progressbar" "sparkle_formation" "table_print"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zxdcc95kvjsbj7nmm1d6xb1blfwxybj1aqx01ibaygjvhh13v5h";
      type = "gem";
    };
    version = "2.6.0";
  };
  table_print = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ibn9gji5fb6c9xmvm977y9k7r61yd9ypbsgxgr527rc9a8cs9v7";
      type = "gem";
    };
    version = "1.5.6";
  };
  thread_safe = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nmhcgq6cgz44srylra07bmaw99f5271l0dpsvl5f75m44l0gmwy";
      type = "gem";
    };
    version = "0.3.6";
  };
  tzinfo = {
    dependencies = ["thread_safe"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1i3jh086w1kbdj3k5l60lc3nwbanmzdf8yjj3mlrx9b2gjjxhi9r";
      type = "gem";
    };
    version = "1.2.7";
  };
  zeitwerk = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1akpm3pwvyiack2zk6giv9yn3cqb8pw6g40p4394pdc3xmy3s4k0";
      type = "gem";
    };
    version = "2.3.0";
  };
}