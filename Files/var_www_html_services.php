<HTML>
<HEAD>
<TITLE> Kubernerdes Services | &#169 2024 </TITLE>
<meta http-equiv="refresh" content="10; url=./services.php">
</HEAD>
<BODY>
<TABLE>
<TH colspan=3> Kubernerdes Services and Endpoints</TH>
<TR><TD><font color=blue>Namespace</TD><TD><font color=blue>Service</TD><TD><font color=blue>Endpoint</TD></TR>

<?php
# You will need to copy the correct KUBECONFIG to the following location
$kubeconfig="/var/www/html/kubernerdes-eksa-eks-a-cluster.kubeconfig";
putenv ("KUBECONFIG=$kubeconfig");

#$k_output = shell_exec('/usr/local/bin/kubectl get svc -A | grep LoadBalancer | awk \'{ split($6, ports, ":"); print $1 " | " $2 " | http://" $5":"ports[1] }\' ');
#$k_output = shell_exec('/usr/local/bin/kubectl get svc -A | grep LoadBalancer | awk \'{ split($6, ports, ":"); print $1 " | " $2 " | <A HREF=http://" $5":" ports[1] ">" $5":" ports[1] "</A>" }\' ');
$k_output = shell_exec('/usr/local/bin/kubectl get svc -A | grep LoadBalancer | awk \'{ split($6, ports, ":"); print "<TR><TD>" $1 "</TD> <TD>" $2 "</TD>  <TD><A HREF=http://" $5":" ports[1] ">" $5":" ports[1] "</A></TD></TR>" }\' ');


echo "<pre>$k_output</pre>";

?>
</TABLE>
</BODY>
</HTML>
