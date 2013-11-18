package Box2D.Dynamics.Joints
{
    import Box2D.Common.Math.*;

    public class b2Jacobian extends Object
    {
        public var linear1:b2Vec2;
        public var linear2:b2Vec2;
        public var angular2:Number;
        public var angular1:Number;

        public function b2Jacobian()
        {
            linear1 = new b2Vec2();
            linear2 = new b2Vec2();
            return;
        }// end function

        public function Set(param1:b2Vec2, param2:Number, param3:b2Vec2, param4:Number) : void
        {
            linear1.SetV(param1);
            angular1 = param2;
            linear2.SetV(param3);
            angular2 = param4;
            return;
        }// end function

        public function SetZero() : void
        {
            linear1.SetZero();
            angular1 = 0;
            linear2.SetZero();
            angular2 = 0;
            return;
        }// end function

        public function Compute(param1:b2Vec2, param2:Number, param3:b2Vec2, param4:Number) : Number
        {
            return linear1.x * param1.x + linear1.y * param1.y + angular1 * param2 + (linear2.x * param3.x + linear2.y * param3.y) + angular2 * param4;
        }// end function

    }
}
