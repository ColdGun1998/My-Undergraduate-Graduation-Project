#读取配置文件
conf = ConfigParser.ConfigParser()
conf.read("conf/conf.ini")
size = int(conf.get('field','size'))
interval = int(conf.get('field','interval'))
BS = []
for posx in range (0,size+interval,interval):
    for posy in range (0,size+interval,interval):
        BS.append([posx,posy])


'''
轨迹统一用二维列表表示
route：[[x1,y1],[x2,y2],[x3,y3,...]
'''

'''
求两个坐标的欧氏距离
'''
def Ed(m, n):
    return np.sqrt(np.sum((m - n) ** 2))
'''
生成真实的运动轨迹
参数：初始运动轨迹坐标，步长
返回值：随机运动后轨迹
'''
def TrueRoute(true_route,step):
    [posx,posy] = true_route[0]
    while 0<posx<size and 0<posy<size:
        r=random.randint(1,20)
        if 1<=r<=8:
            posx+=step
        elif 9<=r<=12:
            posx+=step
            posy+=step
        else:
            posy+=step
        true_route.append([posx,posy])
    return true_route

'''
生成TDOA的估计轨迹
输入：真实的轨迹、信标有效工作距离BR、噪声级
输出：TDOA估计的轨迹

画
定位误差-不同采样点
平均定位误差-信标有效工作距离
平均有效基站数量-信标有效工作距离
平均定位误差-不同噪声误差

'''

def TdoA(true_route,BR,nsePwr):
    #扫描
    for pos in true_route:
        #判断当前位置的有效信标数量和位置
        effBS = []
        rangeSS = []
        for bs in BS:
            rss = Ed(pos,bs)
            if  rss <= BR:
                effBS.append(bs)
                rangeSS.append(rss)
        #当前位置的有效信标个数
        M = len(effBS)
        #当前位置的TDOA真值（以第一个找到的基站为固定站）
        rdo = [x - rangeSS[0] for x in rangeSS[1:]]
        del rangeSS[0]
#         R = (eye(M-1)+ones(M-1))/2;
        #协方差矩阵
        Q=np.mat(nsePwr*(np.eye(M-1)+np.ones((M-1,M-1)))/2)
        S = np.mat(effBS).T
        rdNse = sqrt(nsePwr/2) * np.random.rand(M,1)
        rd = rdo + [x - rdNse[0] for x in rdNse[1:]];
#         tdPos = TDOALoc(S,rd,Q);
        

        
        
if __name__ == '__main__':
    true_route = [[5,10],[11,25],[17,39]]
    BR = 100
    nsePwr = pow(10,-6)
    TdoA(true_route,BR,nsePwr)

