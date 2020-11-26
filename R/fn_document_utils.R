#BuildParam----
build_params=function(fn){


  gen_param_text_fmla=function(x,fn_formals){


    param=glue("#' @param {x}")
    argsout=NULL
    type=NULL

    if(!is_missing(fn_formals[[x]])){
      type=cglue("\\code{[&&class(eval(fn_formals[[x]]))&&]}")
      argsout=c(argsout, cglue("Defaults to \\code{&&glue_collapse(deparse(fn_formals[[x]]))&&}"))
    }
    glue_collapse(c(param,type, argsout),"  ")

  }
  gen_param_text_assertion=function(x,fn_formals){

    type=paste0("\\code{[",str_remove(as.character(x[[1]]),"assert_"),"]}")
    args=call_args(x)
    constr=args[-1]
    constr=constr[!sapply(constr,is_missing)]
    fn_name=as_string(args[[1]])
    param=glue("#' @param {fn_name}")
    combine=NULL
    if(type%in% c('[any]',"[and]")){
      combine=ifelse(type=="[any]",'or equal to one of the following: ','all of the following: ')
      type= sapply(constr,function(x)str_remove(as.character(x[[1]]),"check_"))   %>% unique()
      type[type%in%c('data_table',"data_frame")]<-
        str_replace(type[type%in%c('data_table',"data_frame")],'\\_',".")
      type=glue('[{type%sep%","}]')
      constr=lapply(constr,call_args) %>% stack_lists() %>% lapply(unique)
    }

    #argument_check<-fread("inst/assets/argument_checks/argument_checks.csv")
    argument_check<-fread(paste0(system.file(package='sDevTools'),"/assets/argument_checks/argument_checks.csv"))
    argument_check[,type:=list(type %>% parse_expr() %>% eval())]
    argsout=NULL
    if(nlen0( constr)){
      for(i in 1:l(constr)){
        cname<-names(constr[i])
        #print(cname)
        if(cname%nin%names(argument_check))next
        arg=constr[[i]]
        arg=expr_deparse(arg)%sep%""
        if(!is.null(combine)&len(arg)>1)arg=glue("{combine}[{arg%sep%','}]")
        #print(arg)
        out=cglue(argument_check[[cname]])

        argsout=c(argsout,out)
        #print(cname)
      }}
    if(!is_missing(fn_formals[[fn_name]])){
      argsout=c(argsout, cglue("Defaults to \\code{&&glue_collapse(deparse(fn_formals[[fn_name]]))&&}"))
    }
    glue_collapse(c(param,type, argsout),"  ")

  }

  fmls=fn_fmls(fn)
  fn_x<-exprs_deparse(call_args(fn_body(fn)))

  param_with_no_assertion=lapply(names(fmls),gen_param_text_fmla,fn_formals=fmls)
  names(param_with_no_assertion)=names(fmls)

  assertions<-str_trim(fn_x%grep%'^assert_\\w+\\(.*\\)') %>% parse_exprs()
  if(l(assertions)>0){
    names(assertions)<-sapply(assertions,
                              function(x)expr_deparse(call_args(x)[[1]])%sep%'')
    if(any(duplicated(names(assertions))))stop("Assertions must be unique")
    assertions<-assertions[names(assertions)%in%names(fmls)]



    param_with_assertion<-lapply(assertions,gen_param_text_assertion,fn_formals=fmls)

    param_with_no_assertion[names(param_with_no_assertion)%IN%names(param_with_assertion)]<-param_with_assertion[names(param_with_no_assertion)%IN%names(param_with_assertion)]
  }
  param_with_no_assertion
}

