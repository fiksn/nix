{
  activesupport = {
    dependencies = ["concurrent-ruby" "i18n" "minitest" "tzinfo"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "110vp4frgkw3mpzlmshg2f2ig09cknls2w68ym1r1s39d01v0mi8";
      type = "gem";
    };
    version = "5.2.3";
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
      sha256 = "1i4djzrynzr4l8mqx946ad6zn7blz2r5jif58y9c0lws6bdc5h1l";
      type = "gem";
    };
    version = "1.0.2";
  };
  aws-partitions = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08i5a52b42x1q26j4rzaxp4hhwl0wzw12jbbjxjifnwi2dm57biy";
      type = "gem";
    };
    version = "1.149.0";
  };
  aws-sdk-acm = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1az93qw2hy9p6fqc0lbd0cj6211d49ah1i2z8ps3aqyfdswcfwzi";
      type = "gem";
    };
    version = "1.19.0";
  };
  aws-sdk-cloudformation = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cbvn75dqmjq93a6lrw2b4dn7b3n3w65mrwrfkc6wvw1rhs34idr";
      type = "gem";
    };
    version = "1.18.0";
  };
  aws-sdk-core = {
    dependencies = ["aws-eventstream" "aws-partitions" "aws-sigv4" "jmespath"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1sng9iagk96r8986gsacljnw357famz5x4xa1wk9xm4cx0bmpm5i";
      type = "gem";
    };
    version = "3.48.3";
  };
  aws-sdk-ec2 = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17b4r003v22q1kmqza7a89hpzslxv5hgqh3x5l9j7n5p5hbzp7y2";
      type = "gem";
    };
    version = "1.78.0";
  };
  aws-sdk-ecr = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02h44p1xkcp5vsbav8yv97fpm9h0pldm7lcair65hp8w0i2n64d3";
      type = "gem";
    };
    version = "1.14.0";
  };
  aws-sdk-kms = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1m64sb5nnpryjmjbgvr5lmlrd06wvafd0ss9i9zf3fsi39hqaicg";
      type = "gem";
    };
    version = "1.16.0";
  };
  aws-sdk-s3 = {
    dependencies = ["aws-sdk-core" "aws-sdk-kms" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1bnihahz0va36jcw5wifw6ad0fdarl0lsils6h50wpvzcxzmlm2i";
      type = "gem";
    };
    version = "1.36.0";
  };
  aws-sdk-sns = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0f31hld7j56l5f3jb5qpixiz0l1haq12qj76y0cgxv58fbfyk65c";
      type = "gem";
    };
    version = "1.12.0";
  };
  aws-sdk-ssm = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rrmindsgai6n1g7ns02a8qj804fqrgykqjpc4rp7bbmzaa2sy5l";
      type = "gem";
    };
    version = "1.42.0";
  };
  aws-sigv4 = {
    dependencies = ["aws-eventstream"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dfc8i5cxjwlvi4b665lbpbwvks8a6wfy3vfmwr3pjdmxwdmc2cs";
      type = "gem";
    };
    version = "1.1.0";
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
      sha256 = "119mwp6paa3k5y71sp1p9vr1qbnhnhznapq5kqjxcp70qlh0f983";
      type = "gem";
    };
    version = "0.16.13";
  };
  colorize = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "133rqj85n400qk6g3dhf2bmfws34mak1wqihvh3bgy9jhajw580b";
      type = "gem";
    };
    version = "0.8.1";
  };
  commander = {
    dependencies = ["highline"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0sry6raysvg9qsx5nqqw09n8r8hvcsqzvci7xp2qk7jq3s9mgvnn";
      type = "gem";
    };
    version = "4.4.5";
  };
  concurrent-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x07r23s7836cpp5z9yrlbpljcxpax14yw4fy4bnp6crhr6x24an";
      type = "gem";
    };
    version = "1.1.5";
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
  dotgpg = {
    dependencies = ["gpgme" "thor"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "17mhijaz511sl2bjvkyjdf07bm2x8x8mbdrz1yi3kpz7dps8pak4";
      type = "gem";
    };
    version = "0.7.0";
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
  gpgme = {
    dependencies = ["mini_portile2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12fqirxr964mc8jwsfl5nif6q4wcckrmj7w4c9ci4xg9xy2b9v6m";
      type = "gem";
    };
    version = "2.0.18";
  };
  hashdiff = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19ykg5pax8798nh1yv71adkx0zzs7gn2rxjj86v7nsw0jba5lask";
      type = "gem";
    };
    version = "0.3.8";
  };
  hashie = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13bdzfp25c8k51ayzxqkbzag3wj5gc1jd8h7d985nsq6pn57g5xh";
      type = "gem";
    };
    version = "3.6.0";
  };
  highline = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01ib7jp85xjc4gh4jg0wyzllm46hwv8p0w1m4c75pbgi41fps50y";
      type = "gem";
    };
    version = "1.7.10";
  };
  i18n = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1hfxnlyr618s25xpafw9mypa82qppjccbh292c4l3bj36az7f6wl";
      type = "gem";
    };
    version = "1.6.0";
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
  mini_portile2 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15zplpfw3knqifj9bpf604rb3wc1vhq6363pd6lvhayng8wql5vy";
      type = "gem";
    };
    version = "2.4.0";
  };
  minitest = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0icglrhghgwdlnzzp4jf76b0mbc71s80njn5afyfjn4wqji8mqbq";
      type = "gem";
    };
    version = "5.11.3";
  };
  multi_json = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rl0qy4inf1mp8mybfk56dfga0mvx97zwpmq5xmiwl5r770171nv";
      type = "gem";
    };
    version = "1.13.1";
  };
  os = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1s401gvhqgs2r8hh43ia205mxsy1wc0ib4k76wzkdpspfcnfr1rk";
      type = "gem";
    };
    version = "1.0.0";
  };
  ruby-progressbar = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1cv2ym3rl09svw8940ny67bav7b2db4ms39i4raaqzkf59jmhglk";
      type = "gem";
    };
    version = "1.10.0";
  };
  sparkle_formation = {
    dependencies = ["attribute_struct" "bogo" "multi_json"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0c6xmd9ndwcqv23b9yhjmbjrvpi4kkrmvf1g1pslhf1c6ac1zfhd";
      type = "gem";
    };
    version = "3.0.38";
  };
  stack_master = {
    dependencies = ["activesupport" "aws-sdk-acm" "aws-sdk-cloudformation" "aws-sdk-ec2" "aws-sdk-ecr" "aws-sdk-s3" "aws-sdk-sns" "aws-sdk-ssm" "cfndsl" "colorize" "commander" "deep_merge" "diffy" "dotgpg" "erubis" "hashdiff" "multi_json" "os" "ruby-progressbar" "sparkle_formation" "table_print"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bim67qhj617jy5ij4wddmwraahz2b5wg9jzhkdb7wbr0v1m6p9b";
      type = "gem";
    };
    version = "1.13.1";
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
  thor = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yhrnp9x8qcy5vc7g438amd5j9sw83ih7c30dr6g6slgw9zj3g29";
      type = "gem";
    };
    version = "0.20.3";
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
      sha256 = "1fjx9j327xpkkdlxwmkl3a8wqj7i4l4jwlrv3z13mg95z9wl253z";
      type = "gem";
    };
    version = "1.2.5";
  };
}