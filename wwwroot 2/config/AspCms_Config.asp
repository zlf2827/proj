<%
Const runMode=0	'��վ����ģʽ��0Ϊ��̬��1Ϊ��̬��
Const sitePath=""	'��վ��Ŀ¼ ����:/cms
Const accessFilePath="data/data.asp"	'access���ݿ��ļ�·��
Const dbType=0  '���ݿ����ͣ�0Ϊaccess��1Ϊsqlserver��
Const databaseServer="."  'sqlserver���ݿ��ַ
Const databaseName="aspcms"  'sqlserver���ݿ�����
Const databaseUser="sa"  'sqlserver���ݿ��˺�
Const databasepwd="sa"  'sqlserver���ݿ�����
Const fileExt=".html"	'�����ļ���չ����htm,html,asp��	
Const upLoadPath="upLoad"	'�ϴ��ļ�Ŀ¼
Const textFilter=""	'���ֹ���
Const tablePrefix="AspCms_"	'���ݿ�ǰ׺
Const upFileSize=20000	'�ϴ��ļ���С����KB
Const upFileWay=1	'�ϴ��ļ���ʽ����(1,������ϴ�,)
Const htmlDir="aspcms"	'�ĵ�HTMLĬ�ϱ���·��

'������
Const siteMode=1	'��վ״̬��0Ϊ�رգ�1Ϊ���У�
Const siteHelp=""	'��վ״̬��0Ϊ�رգ�1Ϊ���У�
Const switchFaq=1	'���Կ��أ�0Ϊ�رգ�1Ϊ������
Const switchFaqStatus=0 '������˿��أ�0Ϊ�����ã�1Ϊ���ã�
Const switchComments=1	'���ۿ��أ�0Ϊ�رգ�1Ϊ������
Const switchCommentsStatus=1	'��������Ƿ����ã�0Ϊ�����ã�1Ϊ���ã�


Const waterMark=0	'ˮӡ(0,1)
Const waterType=0	'ˮӡ����(0Ϊ���֣�1ͼƬ)
Const waterMarkFont=""	'ˮӡ����
Const waterMarkPic="/images/logo.png"	'ˮӡͼƬ
Const waterMarkLocation="1"	'λ��

'�ʼ�����
Const smtp_usermail=""	'�ʼ���ַ
Const smtp_user=""	'�ʼ��˺� 
Const smtp_password=""	'�ʼ����� 
Const smtp_server=""	'�ʼ�������

'���ѹ���
Const messageAlertsEmail=""	'�ʼ���ַ
Const messageReminded=1	'��������
Const orderReminded=1	'��������
Const commentReminded=1	'��������
Const applyReminded=1	'ӦƸ����

Const sortTypes="��ƪ,����,��Ʒ,����,��Ƹ,���,����"

Const dirtyStr=""

'���߿ͷ�
Const serviceStatus=0	'���߿ͷ���ʾ״̬
Const serviceStyle=1	'��ʽ
Const serviceLocation="right"	'��ʾλ��
Const serviceQQ="������ѯ|123456 ��Ʒ��ѯ|123456" 'QQ
'Const serviceEmail="234324324"	'����
'Const servicePhone="43244324324"	'�绰
Const serviceWangWang=""	'����
Const serviceContact="/about/?29.html"	'��ϵ��ʽ����
Const servicekfStatus=0	'53KF��ʾ״̬
Const servicekf=""	'


'�õ�Ƭ����
Const slideImgs="/upLoad/slide/month_1904/201904191613422957.jpg, /upLoad/slide/month_1904/201904191613464190.jpg, /upLoad/slide/month_1904/201904191613514115.jpg, /upLoad/slide/month_1904/20190419161354958.jpg,"	'ͼƬ��ַ
Const slideLinks=", , ,,"	'���ӵ�ַ
Const slideTexts=", , ,,"	'����˵��
Const slideWidth="1102"	'��
Const slideHeight="326"	'��
Const slideTextStatus=0	'����˵������
Const slideNum=4	'����˵������

%>