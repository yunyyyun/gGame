//
//  GameData.swift
//  GravityGame
//
//  Created by mengyun on 16/1/17.
//  Copyright © 2016年 mengyun. All rights reserved.
//

import UIKit

let XNUM=11//22
let YNUM=19//38

class GameData: NSObject {
    var blockData = [Int]()
    var totalBlockNum: Int!
    var startID: Int!
    var updateInterval: NSTimeInterval = 0.5
    
    func setDataWithFlag(flag: Int){
        totalBlockNum = XNUM*YNUM
        blockData.removeAll()
        for _ in 0...totalBlockNum-1{
            blockData+=[0]
        }
        if flag==1{
            for i in 0...XNUM-1{
                for j in 0...YNUM-1{
                    if (i==0||i==XNUM-1||j==0||j==YNUM-1) {
                        blockData[i+j*XNUM]=(-1)
                        totalBlockNum=totalBlockNum-1
                    }
                    if i>1&&i+2<XNUM&&j>1&&j+2<YNUM{
                        blockData[i+j*XNUM]=(-1)
                        totalBlockNum=totalBlockNum-1
                    }
                }
            }
            startID=12//28
            updateInterval=0.1
        }
        if flag==2{
            for i in 0...XNUM-1{
                for j in 0...YNUM-1{
                    if (i==0||i==XNUM-1||j==0||j==YNUM-1) {
                        blockData[i+j*XNUM]=(-1)
                        totalBlockNum=totalBlockNum-1
                    }
                    if i>1&&i+2<XNUM&&j>1&&j+2<YNUM{
                        if ((j==3||j==YNUM-4)&&i<=XNUM-4)||(i==XNUM-4&&j>3&&j<YNUM-4)
                        {}
                        else{
                            blockData[i+j*XNUM]=(-1)
                            totalBlockNum=totalBlockNum-1
                        }
                    }
                }
            }
            startID=23//28
        }
        if flag==3{
            for i in 0...XNUM-1{
                for j in 0...YNUM-1{
                    if (i==0||i==XNUM-1||j==0||j==YNUM-1) {
                        blockData[i+j*XNUM]=(-1)
                        totalBlockNum=totalBlockNum-1
                    }
                    if i>1&&i+2<XNUM&&j>1&&j+2<YNUM{
                        if (j==5)
                        {}
                        else{
                            blockData[i+j*XNUM]=(-1)
                            totalBlockNum=totalBlockNum-1
                        }
                    }
                }
            }
            startID=67//28
        }
        if flag==4{
            for i in 0...XNUM-1{
                for j in 0...YNUM-1{
                    blockData[i+j*XNUM]=(-1)
                    totalBlockNum=totalBlockNum-1
                    if (i==1&&j>10)||(i==XNUM-2&&j<YNUM-10){
                        blockData[i+j*XNUM]=0
                        totalBlockNum=totalBlockNum+1
                    }
                }
            }
            startID=8*11+9//45//28
            updateInterval=0.1
        }
        if flag==5{
            for i in 0...XNUM-1{
                for j in 0...YNUM-1{
                    blockData[i+j*XNUM]=(-1)
                    totalBlockNum=totalBlockNum-1
                    if (j==1&&i>5)||(j==YNUM-10&&i<9){
                        blockData[i+j*XNUM]=0
                        totalBlockNum=totalBlockNum+1
                    }
                }
            }
            startID=17//45//28
            updateInterval=0.1
        }
        if flag==6{
            for i in 0...XNUM-1{
                for j in 0...YNUM-1{
                    blockData[i+j*XNUM]=(-1)
                    totalBlockNum=totalBlockNum-1
                    if (j==1&&i>5)||(j==YNUM-10&&i<2||(i==1&&j<8)||(i==1&&j>9)||(i==6&&j>1)){
                        blockData[i+j*XNUM]=0
                        totalBlockNum=totalBlockNum+1
                    }
                }
            }
            startID=11*18+1//45//28
            updateInterval=0.1
        }
        if flag==7{
            for i in 0...XNUM-1{
                for j in 0...YNUM-1{
                    if (i==0||i==XNUM-1||j==0||j==YNUM-1) {
                        blockData[i+j*XNUM]=(-1)
                        totalBlockNum=totalBlockNum-1
                    }
                }
            }
            startID=12//28
        }

    }
}
