Redmine::Plugin.register :redmine_logrobot do
  name 'Redmine Logrobot plugin'
  author 'samchen2009@gmail.com'
  description 'This is a plugin for Redmine to parse the log attached and help QA/Developer to find out the cause through rules '
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  requires_redmine :version_or_higher => '2.1.2'
  menu :top_menu, :LogRobot, {:controller=>'logrobots', :action => 'index'}, :caption => 'Logrobot'
end
