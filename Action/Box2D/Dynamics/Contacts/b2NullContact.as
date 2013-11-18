package Box2D.Dynamics.Contacts
{
    import Box2D.Dynamics.*;

    public class b2NullContact extends b2Contact
    {

        public function b2NullContact()
        {
            return;
        }// end function

        override public function GetManifolds() : Array
        {
            return null;
        }// end function

        override public function Evaluate(param1:b2ContactListener) : void
        {
            return;
        }// end function

    }
}
