package Box2D.Dynamics
{

    public class b2TimeStep extends Object
    {
        public var warmStarting:Boolean;
        public var positionCorrection:Boolean;
        public var dt:Number;
        public var maxIterations:int;
        public var dtRatio:Number;
        public var inv_dt:Number;

        public function b2TimeStep()
        {
            return;
        }// end function

    }
}
