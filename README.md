ZGParallelView
==============

####ParallelView For UITableView

**ParallelView** is the easiest way to add a Parallax effect to a `UITableView`. It works perfectly with `UITableViewController` and is completely compatable with both `UITableViewStyle`.

**Most importantly**
The head view will be a full featured UIView, it can handle touch event or even put a scrollView inside it as well.

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

![img](https://raw.github.com/zhigang1992/ZGParallelView/master/ScreenShotA.png) 
![img](https://raw.github.com/zhigang1992/ZGParallelView/master/ScreenShotB.png)