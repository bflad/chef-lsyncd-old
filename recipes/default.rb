package 'lsyncd'

template '/etc/init.d/lsyncd' do
  source 'lsyncd.init.erb'
  mode '0755'
end

service 'lsyncd' do
  supports :status => true, :restart => true
  action :enable
end

template '/etc/lsyncd.lua' do
  source 'lsyncd.lua.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[lsyncd]', :delayed
end
