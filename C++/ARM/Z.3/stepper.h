
class Stepper
{
	public:
		void StepLeft(void);
		void StepRight(void);
	private:
		unsigned char ucLedCtr;
		void Step(enum Step);
};
