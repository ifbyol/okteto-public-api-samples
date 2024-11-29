package main

import (
	"context"
	"fmt"
	"os"

	"github.com/ifbyol/okteto-public-api-samples/test/okteto"
)

func main() {
	config := okteto.NewConfiguration()
	config.Host = "okteto.ifbyol.dev.okteto.net"
	config.DefaultHeader["Authorization"] = "Bearer 4iwgTsswjktYJKcSAT2D3Os7LnQiLK9DQentWOrLHoqMpG9j"
	client := okteto.NewAPIClient(config)

	ctx := context.Background()
	r, stats, err := client.NamespacesAPI.ListNamespaces(ctx).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "There was an error requesting the namespaces %s\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", stats)
		return
	}

	for _, namespace := range r {
		fmt.Printf("Namespace %q\n", namespace.Name)
	}
}
