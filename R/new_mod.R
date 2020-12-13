#' Create a shiny module template.

#' @name new_mod
#' @param fn_args  \code{[call]} \code{function_name(...)}
#' @param desc  \code{[string]} what the function does.
#' @param return  \code{[string]} what the function returns.
#' @return \code{new_fn}:\code{[NULL]}
#' @examples

#'  if (interactive()) {
#'  new_mod(
#'     myMod(
#'       id=string(),
#'        x=reactive(type='numeric',lower = 0, upper = 1),
#'        y=reactive(type='numeric',lower = 0, upper = 1),
#'         na.rm =reactive(type='logical',len=1)
#'         ),
#'  desc = 'What this module does',
#'  return = 'What this module returns')
#'  }
#' @export
new_mod <- function(fn_args, desc, return) {
  # Create a package function template
  fn_args <- enexpr(fn_args)
  assert_call(fn_args)
  assert_string(desc)
  assert_string(return)

  name = fn_args[[1]]
  mod_server_name=paste0(name,'_server')
  mod_ui_name=paste0(name,'_ui')
  fn_args[[1]] <- sym(".")
  dots = fn_args
  if('id'%nin%names(dots))
    g_stop("module must have an id argument")
  asserts=""
  args=""

  if(nnull(names(dots))){
    c(asserts,args) %<-% make_fn_asssertion(dots)
    asserts<-lapply(asserts,function(x){
      if(is_call(x,'assert_reactive'))
        x=expr_call_modify(x,.m=!!mod_server_name)
      return(x)
    })
    asserts =paste0(names(dots)[-1],"<-", exprs_deparse(asserts))
    c(rctv_asserts,nrctv_asserts)%<-%split_vec(asserts,asserts%detect%'reactive')
  }

  examples =c(glue('fn_document({mod_server_name},'),'{',shiny_module_template(name =name, args = args),'})',glue('fn_document({mod_ui_name},rdname="{mod_server_name}")'))


  mod_id = expr_deparse_lines({
    !!sym(mod_ui_name) <- function(id){
      "#Documentation"
      fdoc(!!desc,!!return)
      ns <- NS(id)
      tagList(

      )
    }
}) %>% str_splitn()
  mod_server = expr_deparse_lines({
    !!sym(mod_server_name)<-
         function(fn_module_args_._){
      "#Documentation"
      fdoc(!!desc,!!return)
      "#Non-reactive assertions"
      !!!parse_exprs(nrctv_asserts)
      moduleServer( id, function(input, output, session){
        ns <- session$ns
        "#Reactive assertions"
       !!!parse_exprs(rctv_asserts)
        "#TO DO"
        "#"
      })
    }
    }) %>% str_replace_all('fn_module_args_\\._',args) %>% str_splitn()

  value<-c('# Module UI',mod_id,"","# Module Server", mod_server)

  value[grepl('\\#',value)]<-
    str_remove_all(value[grepl('\\#',value)],'"|"#"')

  value= c(value,examples)%sep%'\n'
  sd = getActiveDocumentContext()
  rowid <- as.numeric(unlist(sd$selection)[1])

  contents <- sd$contents
  start = rowid - which(rev(grepl("new_mod\\(", contents[1:rowid]))) + 1
  end = rowid - 1
  ranges = document_range(document_position(start, 1), document_position(end, Inf))
  newp = which(grepl("#TO DO", str_split(value, "\n")[[1]]))

  modifyRange(location = ranges, text = value)
  setCursorPosition(document_position(start + newp, 4))
  # Returns: [NULL]
}
