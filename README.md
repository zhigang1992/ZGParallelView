ZGParallelView
==============

####ParallelView For UITableView

`ParallelView` is the easiest way to add a Parallax effect to a `UITableView`. It works perfectly with `UITableViewController` and is completedly compatable with either `UITableViewStyle`

####Install

1. Drag and Copy the `UITableView+ZGParallelView.h` and `UITableView+ZGParallelView.m` into your project.
2. Import those two files into your VC.
3. In `ViewDidLoad`. Initialate the parallelView:

  	- (void)addParallelViewWithUIView:(UIView *)aViewToAdd;
		//or
		- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio;
		//By default, displayRadio is 0.5
		
4. In your `UITableViewDelegate`, implement thi method `scrollViewDidScroll:(UIScrollView *)` like this:
		- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
		    [self.tableView updateParallelView];
		}	

####Screenshot

![img](http://ww2.sinaimg.cn/large/a74ecc4cjw1e0lgknqdpqj.jpg) 
![img](http://ww3.sinaimg.cn/large/a74eed94jw1e0lglifmqej.jpg)
