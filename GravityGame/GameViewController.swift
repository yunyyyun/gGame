//
//  GameViewController.swift
//  GravityGame
//
//  Created by mengyun on 16/1/17.
//  Copyright © 2016年 mengyun. All rights reserved.
//

import UIKit
import CoreMotion

let totalGuanShu = 6

class GameViewController: UIViewController{
    
    var diJiGuan: Int = 1
    var passView: UIView!
    var passViewLabel: UILabel!
    var gameHelpLabel: UILabel!
    var gameView: UIView!
    var mManager: CMMotionManager!
    var preNum: Int!
    var currentNum: Int!
    var gameData: GameData!
    var blockNum: NSInteger!{
        didSet{
            print("fuck................",blockNum,gameData.totalBlockNum)
            if blockNum==gameData.totalBlockNum{
                pushPassView()
                mManager.stopAccelerometerUpdates()
                diJiGuan = diJiGuan+1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //diJiGuan=0
        mManager=CMMotionManager()
        initWithNumber()
        gameData=GameData()
        setDataWithNumber(diJiGuan)
        view.backgroundColor = UIColor.lightGrayColor()
        let updateInterval: NSTimeInterval = 0.1
        test(updateInterval)
        UIApplication.sharedApplication().applicationSupportsShakeToEdit=true
        self.becomeFirstResponder()
    }

    func initWithNumber(){
        let totalWidth = self.view.frame.size.width;
        let width = totalWidth/CGFloat(XNUM);
        
        gameView = UIView(frame: CGRectMake(0, 18, self.view.frame.size.width, self.view.frame.size.height))
        view.addSubview(gameView)
        
        for j in 0...YNUM-1{
            for i in 0...XNUM-1{
                let cellBtnX=width*CGFloat(i)
                let cellBtnY = width*CGFloat(j)
                let cellBtn = UIButton(type: .Custom)
                let spaceWidth: CGFloat = 1.0
                cellBtn.frame = CGRectMake(cellBtnX+spaceWidth, cellBtnY+spaceWidth, width-1.5*spaceWidth, width-1.5*spaceWidth)
                cellBtn.accessibilityIdentifier = NSString(format: "%d", i+j*XNUM) as String
                cellBtn.layer.cornerRadius = 3.0
                gameView.addSubview(cellBtn)
            }
        }
        gameHelpLabel = UILabel(frame: CGRectMake(80,80+18,gameView.frame.width-160,gameView.frame.height-180))
        gameHelpLabel.backgroundColor=UIColor(red: 1.0, green: 0.8, blue: 0.7, alpha: 0.9)
        gameHelpLabel.numberOfLines=18
        gameHelpLabel.text="游戏说明：\n1.白色可行，黑色不可行\n2.每个白色区域走过一次则过关\n3.通过重力感应往4个方向移动\n4.复杂的关卡请先想好再开始\n5.摇一摇手机能重新开始这关\n6.还没想好"
        view.addSubview(gameHelpLabel)
    }
    
    //设置游戏数据，并更新游戏
    func setDataWithNumber(number: Int){
        if !(gameHelpLabel==nil)&&diJiGuan>1{
            gameHelpLabel.hidden=true
        }
        gameData.setDataWithFlag(number)
        currentNum = gameData.startID
        preNum=0
        var btnID: Int
        for view in gameView.subviews{
            btnID = Int(view.accessibilityIdentifier!)!
            view.backgroundColor=gameData.blockData[btnID]==0 ?UIColor.whiteColor():UIColor.blackColor()
            if btnID==currentNum{
                gameData.blockData[btnID]=1
                view.backgroundColor=gameData.blockData[btnID]==0 ?UIColor.whiteColor():UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.8)
            }
        }
        blockNum=1
    }

    
    func pushPassView(){
        if totalGuanShu==diJiGuan{
            for view in passView.subviews{
                view.removeFromSuperview()
            }
            passView.hidden=false
            passViewLabel = UILabel(frame: CGRectMake(10,5,passView.frame.width-20,passView.frame.height-10))
            passViewLabel.text = "恭喜通过所有关卡!"
            passViewLabel.textColor=UIColor.purpleColor()
            passViewLabel.font=UIFont.systemFontOfSize(28)
            passViewLabel.textAlignment = NSTextAlignment.Center
            passView.addSubview(passViewLabel)
        }
        else if passView==nil{
            let width = view.frame.width
            let height = view.frame.height
            passView = UIView(frame: CGRectMake(10, height/2-80, width-20, 100))
            passView.backgroundColor=UIColor.whiteColor()
            passView.layer.cornerRadius = 6.0
            passView.layer.borderWidth = 1.0
            passView.layer.borderColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1).CGColor
            passViewLabel = UILabel(frame: CGRectMake(10,5,passView.frame.width-20,passView.frame.height-60))
            passViewLabel.text = NSString(format: "恭喜通过第%d关!", diJiGuan) as String
            passViewLabel.textAlignment = NSTextAlignment.Center
            //passViewLabel.backgroundColor=UIColor.purpleColor()
            let stepToNext = UIButton(type: .Custom)
            stepToNext.setTitle("下一关", forState:UIControlState.Normal)
            stepToNext.frame = CGRectMake(20, passView.frame.height-50, passView.frame.width-40, 40)
            stepToNext.backgroundColor=UIColor(red: 1.0, green: 0.8, blue: 0.7, alpha: 0.3)
            stepToNext.setTitleColor(UIColor.purpleColor(),forState: .Normal)
            stepToNext.layer.cornerRadius = 6.0
            stepToNext.layer.borderWidth = 1.0
            stepToNext.layer.borderColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1).CGColor
            stepToNext.addTarget(self, action:Selector("nextBtnclick:"), forControlEvents: .TouchUpInside)
            passView.addSubview(passViewLabel)
            passView.addSubview(stepToNext)
            view.addSubview(passView)
        }
        else{
            passView.hidden=false
            passViewLabel.text = NSString(format: "第%d关通过", diJiGuan) as String
        }
        let animation = CATransition()
        animation.delegate = self;
        animation.duration = 1.0;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = "CameraIrisHollowOpen"
        view.layer.addAnimation(animation, forKey: "animation")
    }
    
//    func cellBtnclick(){
//        pushPassView()
//        diJiGuan = diJiGuan+1
//    }
    
    func nextBtnclick(btn: UIButton){
        passView.hidden = true
        //gameData.setDataWithFlag(diJiGuan)
        setDataWithNumber(diJiGuan)
        //mManager.startAccelerometerUpdates()
        let updateInterval: NSTimeInterval = gameData.updateInterval
        test(updateInterval)
    }
    
    func test(updateInterval: NSTimeInterval){
        if mManager.accelerometerAvailable{
            mManager.accelerometerUpdateInterval=updateInterval
             let queue = NSOperationQueue.currentQueue()
            mManager.startAccelerometerUpdatesToQueue(queue!, withHandler: {
                (accelerometerData : CMAccelerometerData?, error : NSError?)->Void in
                let xx = accelerometerData?.acceleration.x
                let yy = accelerometerData?.acceleration.y
                let XX=((xx>0) ? xx : 0-xx!)
                let YY=((yy>0) ? yy : 0-yy!)
                var currentX = self.currentNum%XNUM;
                var currentY = self.currentNum/XNUM;
                let tmpX=currentX
                let tmpY=currentY
                if (XX > YY) {
                    if (XX>0.5) {
                        if (xx>0){
                            //currentX+2>XNUM ?currentX:(currentX+1);
                            if currentX+1==XNUM{
                                let tmpNum = currentX+currentY*XNUM
                                if -1==self.gameData.blockData[tmpNum]{
                                }else{
                                    self.currentNum=tmpNum
                                    self.jump(1)
                                    currentX = self.currentNum%XNUM;
                                    currentY = self.currentNum/XNUM;
                                }
                            }
                            else{
                                currentX=currentX+1
                            }
                            
                        }else{
                             //currentX-1<0 ?currentX:currentX-1;
                            if currentX==0{
                                let tmpNum = currentX+currentY*XNUM
                                if -1==self.gameData.blockData[tmpNum]{
                                }else{
                                    self.currentNum=tmpNum
                                    self.jump(2)
                                    currentX = self.currentNum%XNUM;
                                    currentY = self.currentNum/XNUM;
                                }
                            }
                            else{
                                currentX=currentX-1
                            }
                        }
                    }
                    else{
                        return;
                    }
                }
                else{
                    if (YY>0.5) {
                        if (yy<0){
                            //currentY+2>YNUM ?currentY:(currentY+1);
                            if currentY+1==YNUM{
                                let tmpNum = currentX+currentY*XNUM
                                if -1==self.gameData.blockData[tmpNum]{
                                }else{
                                    self.currentNum=tmpNum
                                    self.jump(3)
                                    currentX = self.currentNum%XNUM;
                                    currentY = self.currentNum/XNUM;
                                }
                            }
                            else{
                                currentY=currentY+1
                            }
                        }
                        else{
                            //currentY-1<0 ?currentY:currentY-1;
                            if currentY==0{
                                let tmpNum: Int = currentX+currentY*XNUM
                                if -1==self.gameData.blockData[tmpNum]{
                                }else{
                                    self.currentNum=tmpNum
                                    self.jump(4)
                                    currentX = self.currentNum%XNUM;
                                    currentY = self.currentNum/XNUM;
                                }
                            }
                            else{
                                currentY=currentY-1
                            }
                        }
                    }
                    else{
                        return;
                    }
                }
//                if currentX==0||currentX+1==XNUM||currentY==0||currentY+1==YNUM{
//                    self.jump(currentX,y: currentY)
//                }
                //print("_%d_%d_%d_%d_",tmpX,tmpY,currentX,currentY)
                let tmpNum=tmpX+tmpY*XNUM
                self.currentNum = currentX+currentY*XNUM
                if self.currentNum==self.preNum{
                    self.preNum=tmpNum
                    if self.gameData.blockData[self.currentNum]==1{
                        self.gameData.blockData[self.currentNum]=0
                        self.blockNum=self.blockNum-1
                    }
                    else{
                        self.gameData.blockData[self.currentNum]=1
                        self.blockNum=self.blockNum+1
                    }
                    if self.gameData.blockData[tmpNum]==1{
                        self.gameData.blockData[tmpNum]=0
                        self.blockNum=self.blockNum-1
                    }
                    else{
                        self.gameData.blockData[tmpNum]=1
                        self.blockNum=self.blockNum+1
                    }
                    self.gameView.subviews[tmpNum].backgroundColor=self.gameData.blockData[tmpNum]==1 ?UIColor.grayColor():UIColor.whiteColor()
                    self.gameView.subviews[self.currentNum].backgroundColor=UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.8)
                    return;
                }
                if self.gameData.blockData[self.currentNum]==(-1){//碰撞检测，走到黑墙
                    currentX=tmpX
                    currentY=tmpY
                    self.currentNum = currentX+currentY*XNUM
                    return;
                }
                else{
                    self.gameView.subviews[tmpNum].backgroundColor=self.gameData.blockData[tmpNum]==1 ?UIColor.grayColor():UIColor.whiteColor()
                    if self.gameData.blockData[self.currentNum]==1{
                        self.gameData.blockData[self.currentNum]=0
                        self.blockNum=self.blockNum-1
                    }
                    else{
                        self.gameData.blockData[self.currentNum]=1
                        self.blockNum=self.blockNum+1
                    }
                }
                self.gameView.subviews[self.currentNum].backgroundColor=UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.8)
                self.preNum=tmpNum
            })
        }
    }
    
    func jump(flag: Int){
        var jumpX: Int = 0
        var jumpY: Int = 0
        //blockNum=blockNum+1
        if flag==2{
            jumpX=XNUM-1
            for j in 0...YNUM-1{
                if !(gameData.blockData[j*XNUM+jumpX]==(-1)) {
                    jumpY=j
                }
            }
        }
        else if flag==1{
            jumpX=0
            for j in 0...YNUM-1{
                if !(gameData.blockData[j*XNUM]==(-1)) {
                    jumpY=j
                }
            }
        }
        else if flag==4{
            jumpY=YNUM-1
            for i in 0...XNUM-1{
                if !(gameData.blockData[jumpY*XNUM+i]==(-1)) {
                    jumpX=i
                }
            }
        }
        else{
            jumpY=0
            for i in 0...XNUM-1{
                if !(gameData.blockData[i]==(-1)) {
                    jumpX=i
                }
            }
        }
        //blockNum=blockNum+1
        self.currentNum = jumpY*XNUM+jumpX
        self.gameView.subviews[self.currentNum].backgroundColor=UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.8)
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        mManager.stopAccelerometerUpdates()
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if passView==nil||passView.hidden{//
            setDataWithNumber(diJiGuan)
            //mManager.startAccelerometerUpdates()
            let updateInterval: NSTimeInterval = gameData.updateInterval
            test(updateInterval)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation
    - (void) test
    {
    if ([self.mManager isAccelerometerAvailable] == YES) {
    [self.mManager setAccelerometerUpdateInterval:0.1];
    
    /* 加速度传感器开始采样，每次采样结果在block中处理 */
    [self.mManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
    {
    double xx = accelerometerData.acceleration.x;
    double yy = accelerometerData.acceleration.y;
    double XX = xx>0?xx:0-xx;
    double YY = yy>0?yy:0-yy;
    //NSLog(@"%lf_%lf",xx,yy);
    NSInteger curentX = _currentNum%22;
    NSInteger curentY = _currentNum/22;
    if (XX > YY) {
    if (XX >0.5) {
    if (xx>0){
    curentX = curentX+2>XNUM-1?curentX:curentX+1;
    }else{
    curentX = curentX-2<0?curentX:curentX-1;
    }
    }
    }else{
    if (YY >0.5) {
    if (yy<0){
    curentY = curentY+2>YNUM-1?curentY:curentY+1;
    }else{
    curentY = curentY-2<0?curentY:curentY-1;
    }
    }
    }
    self.currentNum = curentX + curentY* XNUM;
    }];
    }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
