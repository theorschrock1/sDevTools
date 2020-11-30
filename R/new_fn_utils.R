#assert_for new_fn----
assert_env=function(){
  env(
    call=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,expr(assert_call(!!!dots)))
    },
    expr=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_expr(!!!dots)))
    },
    exprs=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_exprs(!!!dots)))
    },
    list=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      c(default,rlang::expr(assert_list(!!!dots)))
    },
    string=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_string(!!!dots)))
    },
    char=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_character(!!!dots)))
    },
    data_table=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_data_table(!!!dots)))
    },
    choice=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_choice(!!!dots)))
    },
    date=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_date(!!!dots)))
    },
    factor=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_factor(!!!dots)))
    },
    TF=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_logical(!!!dots,len=1)))
    },
    logical=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_logical(!!!dots)))
    },
    int=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_int(!!!dots)))
    },
    integer=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_integerish(!!!dots)))
    },
    class=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_class(!!!dots)))
    },
    R6=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_r6(!!!dots)))
    },
    subset=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_subset(!!!dots)))
    },
    file=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_file(!!!dots)))
    },
    dir=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_directory(!!!dots)))
    },
    package=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_package(!!!dots)))
    },
    num=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_number(!!!dots)))
    },
    numeric=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_numeric(!!!dots)))
    },
    datetime=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_posixct(!!!dots)))
    },
    env=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_environment(!!!dots)))
    },
    fun=function(default,...){
      dots=.(...)
      default<-enexpr(default)
      if(missing(default))default=""
      default= c("=",expr_deparse(default))%sep%""
      if(default=='=""')default=""
      .(default,rlang::expr(assert_function(!!!dots)))
    }
  )
}
