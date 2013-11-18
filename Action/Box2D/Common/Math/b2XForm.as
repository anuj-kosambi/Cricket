package Box2D.Common.Math
{

    public class b2XForm extends Object
    {
        public var R:b2Mat22;
        public var position:b2Vec2;

        public function b2XForm(param1:b2Vec2 = null, param2:b2Mat22 = null) : void
        {
            position = new b2Vec2();
            R = new b2Mat22();
            if (param1)
            {
                position.SetV(param1);
                R.SetM(param2);
            }
            return;
        }// end function

        public function Initialize(param1:b2Vec2, param2:b2Mat22) : void
        {
            position.SetV(param1);
            R.SetM(param2);
            return;
        }// end function

        public function Set(param1:b2XForm) : void
        {
            position.SetV(param1.position);
            R.SetM(param1.R);
            return;
        }// end function

        public function SetIdentity() : void
        {
            position.SetZero();
            R.SetIdentity();
            return;
        }// end function

    }
}
