require 'rake'
require 'rubygems/version'

task :default   => [:release]

desc 'Release new version.'
task :release, ["version"] do |task, args|
  version = args.version

  merge_branch
  update_version(version)
  commit_changes(version)
  push_to_remote_repository
  add_tags(version)
  update_dev_branch
end

def merge_branch
  sh 'git checkout master'
  sh 'git pull origin develop'
end
def update_version(version)
  src = IO.read('./build/jiji/Dockerfile')
  check_version(src, version)
  src = src.gsub(/git\sclone\s\-b\sv([^\s]*)\s/, "git clone -b v#{version} ")
  IO.write('./build/jiji/Dockerfile', src)
end
def commit_changes(version)
  sh "git commit -a -m 'release #{version}'"
end
def push_to_remote_repository
  sh 'git push origin master'
end
def add_tags(version)
  sh "git tag 'v#{version}'"
  sh 'git push --tag'
end
def update_dev_branch
  sh 'git checkout develop'
  sh 'git pull --rebase origin master'
end
def extract_version(src)
  strs = src.scan(/git\sclone\s\-b\sv([^\s]*)\s/)
  Gem::Version.create(strs[0][0])
end
def check_version(src, new_version)
  current = extract_version(src)
  new_version = Gem::Version.create(new_version)
  if current >= new_version
    raise "illegal version. new=#{new_version} current=#{current}"
  end
end
