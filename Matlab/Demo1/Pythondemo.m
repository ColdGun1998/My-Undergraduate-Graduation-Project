#��ȡ�����ļ�
conf = ConfigParser.ConfigParser()
conf.read("conf/conf.ini")
size = int(conf.get('field','size'))
interval = int(conf.get('field','interval'))
BS = []
for posx in range (0,size+interval,interval):
    for posy in range (0,size+interval,interval):
        BS.append([posx,posy])


'''
�켣ͳһ�ö�ά�б��ʾ
route��[[x1,y1],[x2,y2],[x3,y3,...]
'''

'''
�����������ŷ�Ͼ���
'''
def Ed(m, n):
    return np.sqrt(np.sum((m - n) ** 2))
'''
������ʵ���˶��켣
��������ʼ�˶��켣���꣬����
����ֵ������˶���켣
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
����TDOA�Ĺ��ƹ켣
���룺��ʵ�Ĺ켣���ű���Ч��������BR��������
�����TDOA���ƵĹ켣

��
��λ���-��ͬ������
ƽ����λ���-�ű���Ч��������
ƽ����Ч��վ����-�ű���Ч��������
ƽ����λ���-��ͬ�������

'''

def TdoA(true_route,BR,nsePwr):
    #ɨ��
    for pos in true_route:
        #�жϵ�ǰλ�õ���Ч�ű�������λ��
        effBS = []
        rangeSS = []
        for bs in BS:
            rss = Ed(pos,bs)
            if  rss <= BR:
                effBS.append(bs)
                rangeSS.append(rss)
        #��ǰλ�õ���Ч�ű����
        M = len(effBS)
        #��ǰλ�õ�TDOA��ֵ���Ե�һ���ҵ��Ļ�վΪ�̶�վ��
        rdo = [x - rangeSS[0] for x in rangeSS[1:]]
        del rangeSS[0]
#         R = (eye(M-1)+ones(M-1))/2;
        #Э�������
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

