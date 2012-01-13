SimpleCov.start do
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Libraries', '/lib/'
  
  add_filter '/test/'
  add_filter '/config/'
end