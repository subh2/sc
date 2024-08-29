#!/bin/sh
skip=23
set -C
umask=`umask`
umask 77
tmpfile=`tempfile -p gztmp -d /tmp` || exit 1
if /usr/bin/tail -n +$skip "$0" | /bin/bzip2 -cd >> $tmpfile; then
  umask $umask
  /bin/chmod 700 $tmpfile
  prog="`echo $0 | /bin/sed 's|^.*/||'`"
  if /bin/ln -T $tmpfile "/tmp/$prog" 2>/dev/null; then
    trap '/bin/rm -f $tmpfile "/tmp/$prog"; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile "/tmp/$prog") 2>/dev/null &
    /tmp/"$prog" ${1+"$@"}; res=$?
  else
    trap '/bin/rm -f $tmpfile; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile) 2>/dev/null &
    $tmpfile ${1+"$@"}; res=$?
  fi
else
  echo Cannot decompress $0; exit 1
fi; exit $res
BZh91AY&SYz��  ���EP���/nޮ����    P.�J�;cۂRh�	�~H��{T�M6I�6���yL���)��$~����hz         %*~�jOH�4� �� �   IԞ�S�a=�zz���M4���A��%�MOM'��ji���  4   @~~�&�gw��0�N�QCֽrYt����5����Ӫ�����%:%�9�5�G*�h1>}�q�ْ�X�im~Ň3𱔭/���H���l������ɹ׽��S�f��`���Y��8�`�Y��b�J=�4i�ڷ�8�bI06j��O�k�
#d�[rթ�eK�:��P��!�1��w�[F&`��i���~����vJ9����8����@��6��O�=�
��-i�{	9ӑ�F��;��&�Ԍ�u��'gۥ�L?"��l]���3�oO��v���MuY��Pc��)� N��ĕ�qA�:H�d1}b�Ȍ}�r��^M�ǯX<�Tݲ�)���mԆ�p�b����\j�,&���m�"D��)9��fo��SO%8���0�So8��y����'ѨӵEila?EGS?2
N��a���]nto�	L�g���8Cf�=�=�-���xTLJ/�	AU�i��U\U.�)!(GQ�G;�2J�)@�;�V}Ѡ+����S���I�y���Ό`U2�Q��9�Ţ�Q�3��%VI��M&���I���!rVR]�B�P08{�AU�q!6�"-P��5���H��d	K�د K8P�� �B�H�IJ?q-�F��x��]�T�*L�Ek���A��@V�b)�֯�Q:j�'#� ��#�7d2�20%C�����?��H��M�c� $�my<�%QFA#�5�(vʺF�j��e���q��ϱ�����;�7�C�����U}
+s�rE8P�z��