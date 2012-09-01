<%@ Page Title="" Language="C#"  %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //for (int i = 0; i < 10000; i++)
        //{
        //    TreeNode tn = new TreeNode("xxx");
        //    TreeView1.Nodes.Add(tn);
        //}
        using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
        {
            var donelist = from d in db.m_ima_contact orderby d.ima_contact_id select d.ima_contact_id;
            Response.Write("Total count = " + donelist.Count() + "<BR>");
            int unmap = 0;
            List<int> list = new List<int>();
            foreach(int id  in  donelist){
                Response.Write("ima id = "+id+" ");
                try
                {
                    var imas = db.Ima_Contact.First(c => c.ContactID == id && c.IsTemp == false);
                    Response.Write(" in IMA Contract.<BR>");
                    var contacts = from c in db.contact_info where c.fname == imas.FirstName && c.lname == imas.LastName select c;
                    
                    if (contacts.Count() == 1)
                    {
                        WoWiModel.contact_info cinfo = contacts.First();
                        Response.Write("Found Contract id = " + cinfo.id + "<BR>");
                        //cinfo.ima_contract_id = id;
                        //imas.FirstName = cinfo.fname;
                        //imas.LastName = cinfo.lname;
                        //imas.Title = cinfo.title;
                        //imas.WorkPhone = cinfo.workphone;
                        //imas.Email = cinfo.email;
                        //imas.CellPhone = cinfo.cellphone;
                        //imas.Adress = cinfo.address;
                        //imas.CountryID = cinfo.country_id;
                        //imas.Fax = cinfo.fax;
                        
                    }
                    else
                    {
                        Response.Write("Count ** = " + contacts.Count() + "<BR>");
                        list.Add(id);
                    }      
                }
                catch (Exception ex)
                {
                    list.Add(id);
                    Response.Write("error:"+ex+"<BR>");
                }


                

            }
            //db.SaveChanges();
            Response.Write("Total unmap count = " + list.Count() + "<BR>");
            foreach(int id  in  list)
                Response.Write("Unmap IMA id = " + id + "<BR>");
        }
    }
</script>

