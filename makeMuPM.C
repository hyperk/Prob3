{

  TH1D * mu = (TH1D*) _file0->Get("lmu2eE");
  TH1D * muminus = (TH1D*) _file1->Get("lmu2eE");
  muminus->SetLineColor(kBlue);
  mu->SetLineColor(kRed);
  mu->Draw("");
  muminus->Draw("same");


}
