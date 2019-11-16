using System;

/// <summary>
/// Summary description for Class1
/// </summary>
/// 
namespace AcReport
{
    public class AcNetStream : Object, AcReport.IAcNetStream
    {
        System.IO.Stream mStream;

        public AcNetStream(System.IO.Stream connectStream)
        {
            mStream = connectStream;
        }

        public void ConnectTo(System.IO.Stream connectStream)
        {
            mStream = connectStream;
        }

        public int GetSize()
        {
            return (int)mStream.Length;

        }

        public int Read(ref string Buffer, int Count)
        {

            byte[] buf = new byte[Count];

            int size = mStream.Read(buf, 0, Count);
            int i;

            Buffer = "";
            for (i = 0; i <= size - 1; i++)
                Buffer = Buffer + (Char)buf[i];

            return size;

        }

        public int Seek(int Offset, AcReport.SeekOrg Origin)
        {
            return (int)mStream.Seek(Offset, (System.IO.SeekOrigin)Origin);
        }

        public void SetSize(int NewSize)
        {
            mStream.SetLength(NewSize);
        }

        public int Write(string Buffer, int Count)
        {
            byte[] buf = new byte[Count];
            int i;
            for (i = 0; i <= Count - 1; i++)
                buf[i] = (byte)Buffer[i];
            mStream.Write(buf, 0, Count);

            return Count;
        }
    }

}