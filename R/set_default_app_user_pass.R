#' @export
set_default_app_user_pass=function(user,pw,path=get_wd(),db_name='udb.rds'){
  path_to_db<-path(path,'udb.rds')
  if(!file.exists(path_to_db))
    g_stop('{path_to_db} not found')
  udb<-readRDS('path_to_db')
  udb$reset_user_password(user='user',pw='pw',new_user=user,new_pw=pw)
  saveRDS(udb,path_to_db)
  g_success('default username and password reset')
}
