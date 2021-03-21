# 放弃本地修改
drop:
	git add .; git stash; git stash drop

#合并代码到gray分支 [灰度]-[API]-api.weipaitang.com IP:10.133.199.240  gray分支
gray:
	- git branch -D gray;
	git fetch;
	export branch=`git branch | grep \* | grep -Eo ' .+'` && \
		echo "当前分支: $$branch" && \
		git checkout gray && \
		git pull --rebase && \
		git merge origin/master && \
		echo "merge: \033[0;31morigin/master\033[0m" && \
		git merge $$branch && \
		echo "merge: \033[0;31m$$branch\033[0m" && \
		git push && \
		git checkout $$branch;

#合并代码到gray分支 [灰度2]-[API]-api.weipaitang.com IP:10.105.122.154  gray2分支
gray2:
	- git branch -D gray2;
	git fetch;
	export branch=`git branch | grep \* | grep -Eo ' .+'` && \
		echo "当前分支: $$branch" && \
		git checkout gray2 && \
		git pull --rebase && \
		git merge origin/master && \
		echo "merge: \033[0;31morigin/master\033[0m" && \
		git merge $$branch && \
		echo "merge: \033[0;31m$$branch\033[0m" && \
		git push && \
		git checkout $$branch;

# 快速rebase同步最新master代码，遇到git push推送远端分支时报错(failed to push some refs to)，请执行 git pull --rebase origin $$branch
rebase:
	export branch=`git branch | grep \* | grep -Eo ' .+'` && \
		git checkout master && \
		git pull --rebase && \
		git checkout $$branch && \
		git rebase master;

# 多环境支持，合并开发分支代码到t[1,2,3,4,5,6,7,10]，遇到冲突请手动解决冲突 t1环境，不在docker环境内
t%:
	@echo "当前对应环境名称: env0$* 分支：t$*";
	- git branch -D t$*;
	git fetch;
	export branch=`git branch | grep \* | grep -Eo ' .+'` && \
		echo "当前分支: $$branch" && \
		git checkout t$* && \
		git pull --rebase && \
		git merge origin/master && \
		echo "merge: \033[0;31morigin/master\033[0m" && \
		git merge $$branch && \
		echo "merge: \033[0;31m$$branch\033[0m" && \
		git push && \
		git checkout $$branch;




